/*
 * Licensed Materials - Property of IBM
 * 5737-M66, 5900-AAA, 5900-AMG
 * (C) Copyright IBM Corp. 2025 All Rights Reserved.
 * US Government Users Restricted Rights - Use, duplication, or disclosure
 * restricted by GSA ADP Schedule Contract with IBM Corp.
 */
var eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";
var eventer = window[eventMethod];
var messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";
var isViewerFrameLoaded = false;
var queuedMessages = [ ];

// Listen to message from child window
eventer(messageEvent, function(e) {
    var key = e.message ? "message" : "data";
    var data = e[key];

    if (bimviewerFunctions[data.funcCall]) {
        bimviewerFunctions[data.funcCall](data.passVar);
    }
},false);

// Send message to child window
function maximoToViewerMessage(message, jspScriptId) {
    var viewerFrameId = jspScriptId + '_frame';
    var viewerIFrame = document.getElementById(viewerFrameId);
    if(viewerIFrame) {
        var viewerIFWin = viewerIFrame.contentWindow;
        if(viewerIFWin) {
            if(isViewerFrameLoaded) {
                viewerIFWin.postMessage(message,"*");
            } else {
                queuedMessages.push([message, jspScriptId]);
            }
        }
    }
}

function sendQueuedMessage(isTypeLookup) {
    isViewerFrameLoaded = true;
    queuedMessages.forEach(function(item, index, array) {
        // item[0] is the 'message' and item[1] is the jspScript id
        maximoToViewerMessage(item[0], item[1]);
    });
    queuedMessages = [ ];
    /* In case of TYPE_LOOKUP
        set back 'isViewerFrameLoaded' to 'false' so that messages are posted only after the viewerframe is loaded
        */
    if (isTypeLookup) isViewerFrameLoaded = false;
}

function resizeTarget(hwArg) {
    if(targCtrl) {
        targCtrl.style.height = hwArg.height + "px";
        targCtrl.style.width = hwArg.width + "px";
    }
}

var bimviewerFunctions = {
    'viewerframeLoaded': function(passArg) {sendQueuedMessage(passArg);},
    'resizeTarget': function(passArg) {resizeTarget(passArg);}
}

    
function locRectToWindRect( elem ) {
    if(!elem) return null;
    var target = elem;
    var target_width = target.offsetWidth;
    var target_height = target.offsetHeight;
    var target_left = target.offsetLeft;
    var target_top = target.offsetTop;
    var gleft = 0;
    var gtop = 0;
    var rect = {};

    var getHigher = function( parentElem ) {
        if (!!parentElem) {
            gleft += parentElem.offsetLeft;
            gtop += parentElem.offsetTop;
            getHigher( parentElem.offsetParent );
        } else {
            return rect = {
                top: (target.offsetTop + gtop),
                left: (target.offsetLeft + gleft),
                bottom: ((target.offsetTop + gtop) + target_height),
                right: ((target.offsetLeft + gleft) + target_width)
            };
        }
    };
    getHigher( target.offsetParent );
    return rect;
}

function sameRect(rect1, rect2) {
    return((rect1 && rect2) &&
        rect1.top == rect2.top && 
        rect1.left == rect2.left &&
        rect1.bottom == rect2.bottom && 
        rect1.right == rect2.right);
}

var targCtrl;
var targRect;
var elemParentRect;
var targetTrackingInterval;
function moveToTarg(elemId, targId) {
    
    var ckTarg = document.getElementById(targId);
    var elem = document.getElementById(elemId);
    var elemParent = elem != undefined ? elem.parentElement : undefined;

    if(ckTarg == null && elem) {
        elem.style.display = "none";
        elem.style.visibility = "hidden";
    } else {
        if(elem) {
            elem.style.display = "block";
            elem.style.visibility = "visible";
        }
    }

    var targMoved = (targCtrl == undefined || !sameRect(targRect, locRectToWindRect(ckTarg)));
    var elemParentMoved = (elemParentRect == undefined || !sameRect(elemParentRect, locRectToWindRect(elemParent)));
    if(ckTarg && (targMoved || elemParentMoved)) {

        targCtrl = document.getElementById(targId);
        if(elem && !sameRect(locRectToWindRect(elem), locRectToWindRect(ckTarg))) {
            elemParentRect = locRectToWindRect(elemParent);
            targRect = locRectToWindRect(ckTarg);
            var newElemTop = targRect.top - elemParentRect.top;
            var newElemLeft = targRect.left - elemParentRect.left;
            elem.style.top = newElemTop + "px";
            elem.style.left = newElemLeft + "px";
            elem.style.height = targCtrl.style.height;
            elem.style.width = targCtrl.style.width;
            
            if(!targetTrackingInterval) {
                targetTrackingInterval = setInterval(moveToTarg, 100, elemId, targId);
            }
        }
    }
}
