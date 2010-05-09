/* (MIT License)
 
 Copyright (c) 2010 Phillip Jordan <phil@philjordan.eu>

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */

/**
 * Spawns a new multi-async handler.
 * @class <p>Allows easy handling of dependency on multiple asynchronous events.
 * To use, create a new instance, use the return values of cb() calls as
 * callbacks to the events and finally set the final handler with whenDone().</p>
 * <p>If <code>sync()</code> is available, it will be used so the AsyncHandler is
 * thread-safe.</p>
 */
function AsyncHandler() {
	if (!this instanceof AsyncHandler) return new AsyncHandler();
	this.args = [];
}

AsyncHandler.prototype = {
	waiting:0,
	args:[],
	next_idx:0,
	final_cb:null,
	final_cb_this:null,

	/** returns a function to be used as an async callback; final callback triggers
	 * when/if all these have been called
	 */
	cb: function(chained_cb) {
		var idx = this.next_idx++;
		this.waiting++;
		var handler = this; /* capture 'this' in closure scope */

		var fn = function(data){
			handler.args[idx] = data;
			if(--handler.waiting == 0 && handler.final_cb) {
				handler.final_cb.apply(handler.final_cb_this, handler.args);
			}
			if (chained_cb) /* forward to any extra callbacks */
				chained_cb.apply(this, arguments);
		};
		return fn;
	},

	/** like cb() but remembers array of arguments to the callback, not just the first one
	 */
	cbArray: function(chained_cb) {
		var idx = this.next_idx++;
		this.waiting++;
		var handler = this; /* capture 'this' in closure scope */

		var fn = function(){
			handler.args[idx] = arguments;
			if(--handler.waiting == 0 && handler.final_cb) {
				handler.final_cb.apply(handler.final_cb_this, handler.args);
			}
			if (chained_cb) /* forward to any extra callbacks */
				chained_cb.apply(this, arguments);
		};
		return fn;
	},

	// signals that all required callbacks have been produced and registers the completion function
	whenDone: function(fn, this_obj) {
		this.final_cb_this = this_obj || this;
		this.final_cb = fn;
		if (this.waiting == 0) {
			this.final_cb.apply(this.final_cb_this, this.args);
		}
	}
};