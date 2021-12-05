(self.webpackChunkdask_labextension=self.webpackChunkdask_labextension||[]).push([[214],{214:(e,t,n)=>{"use strict";Object.defineProperty(t,"__esModule",{value:!0});var i=n(377);t.Poll=i.Poll;var r=n(628);t.Debouncer=r.Debouncer,t.RateLimiter=r.RateLimiter,t.Throttler=r.Throttler},377:function(e,t,n){"use strict";var i=this&&this.__assign||function(){return(i=Object.assign||function(e){for(var t,n=1,i=arguments.length;n<i;n++)for(var r in t=arguments[n])Object.prototype.hasOwnProperty.call(t,r)&&(e[r]=t[r]);return e}).apply(this,arguments)},r=this&&this.__awaiter||function(e,t,n,i){return new(n||(n=Promise))((function(r,o){function s(e){try{u(i.next(e))}catch(e){o(e)}}function a(e){try{u(i.throw(e))}catch(e){o(e)}}function u(e){var t;e.done?r(e.value):(t=e.value,t instanceof n?t:new n((function(e){e(t)}))).then(s,a)}u((i=i.apply(e,t||[])).next())}))},o=this&&this.__generator||function(e,t){var n,i,r,o,s={label:0,sent:function(){if(1&r[0])throw r[1];return r[1]},trys:[],ops:[]};return o={next:a(0),throw:a(1),return:a(2)},"function"==typeof Symbol&&(o[Symbol.iterator]=function(){return this}),o;function a(o){return function(a){return function(o){if(n)throw new TypeError("Generator is already executing.");for(;s;)try{if(n=1,i&&(r=2&o[0]?i.return:o[0]?i.throw||((r=i.return)&&r.call(i),0):i.next)&&!(r=r.call(i,o[1])).done)return r;switch(i=0,r&&(o=[2&o[0],r.value]),o[0]){case 0:case 1:r=o;break;case 4:return s.label++,{value:o[1],done:!1};case 5:s.label++,i=o[1],o=[0];continue;case 7:o=s.ops.pop(),s.trys.pop();continue;default:if(!((r=(r=s.trys).length>0&&r[r.length-1])||6!==o[0]&&2!==o[0])){s=0;continue}if(3===o[0]&&(!r||o[1]>r[0]&&o[1]<r[3])){s.label=o[1];break}if(6===o[0]&&s.label<r[1]){s.label=r[1],r=o;break}if(r&&s.label<r[2]){s.label=r[2],s.ops.push(o);break}r[2]&&s.ops.pop(),s.trys.pop();continue}o=t.call(e,s)}catch(e){o=[6,e],i=0}finally{n=r=0}if(5&o[0])throw o[1];return{value:o[0]?o[1]:void 0,done:!0}}([o,a])}}};Object.defineProperty(t,"__esModule",{value:!0});var s,a=n(797),u=n(168),c="function"==typeof requestAnimationFrame?requestAnimationFrame:setImmediate,l="function"==typeof cancelAnimationFrame?cancelAnimationFrame:clearImmediate,h=function(){function e(e){var t=this;this._disposed=new u.Signal(this),this._tick=new a.PromiseDelegate,this._ticked=new u.Signal(this),this._timeout=-1,this._factory=e.factory,this._standby=e.standby||s.DEFAULT_STANDBY,this._state=i(i({},s.DEFAULT_STATE),{timestamp:(new Date).getTime()}),this.frequency=i(i({},s.DEFAULT_FREQUENCY),e.frequency||{}),this.name=e.name||s.DEFAULT_NAME,"auto"in e&&!e.auto||c((function(){t.start()}))}return Object.defineProperty(e.prototype,"disposed",{get:function(){return this._disposed},enumerable:!0,configurable:!0}),Object.defineProperty(e.prototype,"frequency",{get:function(){return this._frequency},set:function(t){if(!this.isDisposed&&!a.JSONExt.deepEqual(t,this.frequency||{})){var n=t.backoff,i=t.interval,r=t.max;if(i=Math.round(i),r=Math.round(r),"number"==typeof n&&n<1)throw new Error("Poll backoff growth factor must be at least 1");if((i<0||i>r)&&i!==e.NEVER)throw new Error("Poll interval must be between 0 and max");if(r>e.MAX_INTERVAL&&r!==e.NEVER)throw new Error("Max interval must be less than "+e.MAX_INTERVAL);this._frequency={backoff:n,interval:i,max:r}}},enumerable:!0,configurable:!0}),Object.defineProperty(e.prototype,"isDisposed",{get:function(){return"disposed"===this.state.phase},enumerable:!0,configurable:!0}),Object.defineProperty(e.prototype,"standby",{get:function(){return this._standby},set:function(e){this.isDisposed||this.standby===e||(this._standby=e)},enumerable:!0,configurable:!0}),Object.defineProperty(e.prototype,"state",{get:function(){return this._state},enumerable:!0,configurable:!0}),Object.defineProperty(e.prototype,"tick",{get:function(){return this._tick.promise},enumerable:!0,configurable:!0}),Object.defineProperty(e.prototype,"ticked",{get:function(){return this._ticked},enumerable:!0,configurable:!0}),e.prototype.dispose=function(){this.isDisposed||(this._state=i(i({},s.DISPOSED_STATE),{timestamp:(new Date).getTime()}),this._tick.promise.catch((function(e){})),this._tick.reject(new Error("Poll ("+this.name+") is disposed.")),this._disposed.emit(void 0),u.Signal.clearData(this))},e.prototype.refresh=function(){return this.schedule({cancel:function(e){return"refreshed"===e.phase},interval:e.IMMEDIATE,phase:"refreshed"})},e.prototype.schedule=function(t){return void 0===t&&(t={}),r(this,void 0,void 0,(function(){var n,r,s,u,h,p=this;return o(this,(function(o){switch(o.label){case 0:return this.isDisposed||t.cancel&&t.cancel(this.state)?[2]:(n=this.state,r=this._tick,s=new a.PromiseDelegate,u=i({interval:this.frequency.interval,payload:null,phase:"standby",timestamp:(new Date).getTime()},t),this._state=u,this._tick=s,n.interval===e.IMMEDIATE?l(this._timeout):clearTimeout(this._timeout),this._ticked.emit(this.state),r.resolve(this),[4,r.promise]);case 1:return o.sent(),h=function(){p.isDisposed||p.tick!==s.promise||p._execute()},this._timeout=u.interval===e.IMMEDIATE?c(h):u.interval===e.NEVER?-1:setTimeout(h,u.interval),[2]}}))}))},e.prototype.start=function(){return this.schedule({cancel:function(e){var t=e.phase;return"constructed"!==t&&"standby"!==t&&"stopped"!==t},interval:e.IMMEDIATE,phase:"started"})},e.prototype.stop=function(){return this.schedule({cancel:function(e){return"stopped"===e.phase},interval:e.NEVER,phase:"stopped"})},e.prototype._execute=function(){var e=this,t="function"==typeof this.standby?this.standby():this.standby;if(t="never"!==t&&("when-hidden"===t?!("undefined"==typeof document||!document||!document.hidden):t))this.schedule();else{var n=this.tick;this._factory(this.state).then((function(t){e.isDisposed||e.tick!==n||e.schedule({payload:t,phase:"rejected"===e.state.phase?"reconnected":"resolved"})})).catch((function(t){e.isDisposed||e.tick!==n||e.schedule({interval:s.sleep(e.frequency,e.state),payload:t,phase:"rejected"})}))}},e}();t.Poll=h,function(e){e.IMMEDIATE=0,e.MAX_INTERVAL=2147483647,e.NEVER=1/0}(h=t.Poll||(t.Poll={})),t.Poll=h,function(e){e.DEFAULT_BACKOFF=3,e.DEFAULT_FREQUENCY={backoff:!0,interval:1e3,max:3e4},e.DEFAULT_NAME="unknown",e.DEFAULT_STANDBY="when-hidden",e.DEFAULT_STATE={interval:h.NEVER,payload:null,phase:"constructed",timestamp:new Date(0).getTime()},e.DISPOSED_STATE={interval:h.NEVER,payload:null,phase:"disposed",timestamp:new Date(0).getTime()},e.sleep=function(t,n){var i=t.backoff,r=t.interval,o=t.max;if(r===h.NEVER)return r;var s=!0===i?e.DEFAULT_BACKOFF:!1===i?1:i,a=function(e,t){return e=Math.ceil(e),t=Math.floor(t),Math.floor(Math.random()*(t-e+1))+e}(r,n.interval*s);return Math.min(o,a)}}(s||(s={}))},628:function(e,t,n){"use strict";var i,r=this&&this.__extends||(i=function(e,t){return(i=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(e,t){e.__proto__=t}||function(e,t){for(var n in t)t.hasOwnProperty(n)&&(e[n]=t[n])})(e,t)},function(e,t){function n(){this.constructor=e}i(e,t),e.prototype=null===t?Object.create(t):(n.prototype=t.prototype,new n)}),o=this&&this.__awaiter||function(e,t,n,i){return new(n||(n=Promise))((function(r,o){function s(e){try{u(i.next(e))}catch(e){o(e)}}function a(e){try{u(i.throw(e))}catch(e){o(e)}}function u(e){var t;e.done?r(e.value):(t=e.value,t instanceof n?t:new n((function(e){e(t)}))).then(s,a)}u((i=i.apply(e,t||[])).next())}))},s=this&&this.__generator||function(e,t){var n,i,r,o,s={label:0,sent:function(){if(1&r[0])throw r[1];return r[1]},trys:[],ops:[]};return o={next:a(0),throw:a(1),return:a(2)},"function"==typeof Symbol&&(o[Symbol.iterator]=function(){return this}),o;function a(o){return function(a){return function(o){if(n)throw new TypeError("Generator is already executing.");for(;s;)try{if(n=1,i&&(r=2&o[0]?i.return:o[0]?i.throw||((r=i.return)&&r.call(i),0):i.next)&&!(r=r.call(i,o[1])).done)return r;switch(i=0,r&&(o=[2&o[0],r.value]),o[0]){case 0:case 1:r=o;break;case 4:return s.label++,{value:o[1],done:!1};case 5:s.label++,i=o[1],o=[0];continue;case 7:o=s.ops.pop(),s.trys.pop();continue;default:if(!((r=(r=s.trys).length>0&&r[r.length-1])||6!==o[0]&&2!==o[0])){s=0;continue}if(3===o[0]&&(!r||o[1]>r[0]&&o[1]<r[3])){s.label=o[1];break}if(6===o[0]&&s.label<r[1]){s.label=r[1],r=o;break}if(r&&s.label<r[2]){s.label=r[2],s.ops.push(o);break}r[2]&&s.ops.pop(),s.trys.pop();continue}o=t.call(e,s)}catch(e){o=[6,e],i=0}finally{n=r=0}if(5&o[0])throw o[1];return{value:o[0]?o[1]:void 0,done:!0}}([o,a])}}};Object.defineProperty(t,"__esModule",{value:!0});var a=n(797),u=n(377),c=function(){function e(e,t){var n=this;void 0===t&&(t=500),this.payload=null,this.limit=t,this.poll=new u.Poll({auto:!1,factory:function(){return o(n,void 0,void 0,(function(){return s(this,(function(t){switch(t.label){case 0:return[4,e()];case 1:return[2,t.sent()]}}))}))},frequency:{backoff:!1,interval:u.Poll.NEVER,max:u.Poll.NEVER},standby:"never"}),this.payload=new a.PromiseDelegate,this.poll.ticked.connect((function(e,t){var i=n.payload;return"resolved"===t.phase?(n.payload=new a.PromiseDelegate,void i.resolve(t.payload)):"rejected"===t.phase||"stopped"===t.phase?(n.payload=new a.PromiseDelegate,i.promise.catch((function(e){})),void i.reject(t.payload)):void 0}),this)}return Object.defineProperty(e.prototype,"isDisposed",{get:function(){return null===this.payload},enumerable:!0,configurable:!0}),e.prototype.dispose=function(){this.isDisposed||(this.payload=null,this.poll.dispose())},e.prototype.stop=function(){return o(this,void 0,void 0,(function(){return s(this,(function(e){return[2,this.poll.stop()]}))}))},e}();t.RateLimiter=c;var l=function(e){function t(){return null!==e&&e.apply(this,arguments)||this}return r(t,e),t.prototype.invoke=function(){return o(this,void 0,void 0,(function(){return s(this,(function(e){return this.poll.schedule({interval:this.limit,phase:"invoked"}),[2,this.payload.promise]}))}))},t}(c);t.Debouncer=l;var h=function(e){function t(){return null!==e&&e.apply(this,arguments)||this}return r(t,e),t.prototype.invoke=function(){return o(this,void 0,void 0,(function(){return s(this,(function(e){return"invoked"!==this.poll.state.phase&&this.poll.schedule({interval:this.limit,phase:"invoked"}),[2,this.payload.promise]}))}))},t}(c);t.Throttler=h}}]);