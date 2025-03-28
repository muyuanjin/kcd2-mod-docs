function DoTheMagic(resultArray, showPrev) {
    var resWnd = document.getElementById("result_wnd");
    resWnd.innerHTML = "<a href='#' id='close_button' onclick='CloseSearch();'>Close</a><hr/>";
    //resWnd.innerHTML = "";

    if (resultArray !== 0) {
        resWnd.style = "display: block;";
        for (var i = 0; i < resultArray.length; i++) {
            var row = resultArray[i];
            resWnd.innerHTML = resWnd.innerHTML + "<a href=\"#\" onclick=\"GoToContent('" + row[1] + "');\">" + row[0] + "</a> - " + row[2] + "<br />";
        }

        //*/
        if (oldStartIndex > 0) {
            resWnd.innerHTML = resWnd.innerHTML + "<hr>";
        }

        if (showPrev) {
            resWnd.innerHTML = resWnd.innerHTML + "<a href=\"#\" style=\"text-decoration: none;\" onclick=\"Search('" + oldWhat + "'," + (oldStartIndex * -1) + ");\">&lt;&lt; prev " + maximumCount + "&nbsp;&nbsp;</a>";
        }

        if (oldStartIndex > 0) {
            resWnd.innerHTML = resWnd.innerHTML + "<a href=\"#\" style=\"text-decoration: none;\" onclick=\"Search('" + oldWhat + "'," + oldStartIndex + ");\">next " + maximumCount + " &gt;&gt;</a>";
        }
        //*/

    } else {
        resWnd.style = "display: none;";
    }
}

function GoToContent(contentUrl) {
    var contentWnd = document.getElementById("content_frame");

    if (contentUrl && contentWnd) {
        contentWnd.src = contentUrl;
        CloseSearch();
    }
}

function CloseSearch() {
    var closeLink = document.getElementById("close_button");
    var resWnd = document.getElementById("result_wnd");
    //resWnd.style = "display: none;";
    resWnd.innerHTML = "";
}

var maximumCount = 20;
var oldStartIndex = 0;
var oldWhat = "";

function Search(what, startIndex) {
    var searchFor = what.toLowerCase();
    var resultArr = new Array();
    var i = 0;
    var incr = 1;
    if (startIndex < 0) {
        i = startIndex * -1;
        incr = -1;
    } else {
        i = startIndex;
    }

	var searchForArr = searchFor.split(" ");
	
    for (; (i < document.dictionary.length) && (i >= 0); i = i + incr) {
        var row = document.dictionary[i];
        
		if(searchForArr.length == 1) {
			var indexOf = row[0].toLowerCase().indexOf(searchFor);
			if (indexOf !== -1) {
				resultArr[resultArr.length] = row;
				resultArr[resultArr.length - 1][3] = indexOf;
			} else {
				indexOf = row[2].toLowerCase().indexOf(searchFor);
				if (indexOf !== -1) {
					resultArr[resultArr.length] = row;
					resultArr[resultArr.length - 1][3] = indexOf;
				}
			}
		} else {
			var searchIn = row[0].toLowerCase().concat(" ", row[2].toLowerCase());
			var found = true;

			for(var j = 0; j < searchForArr.length; j++) {
				var indexOf = searchIn.indexOf(searchForArr[j]);
				if (indexOf == -1) {
					found = false; // exit this search when not found, must match all words! (space is used like &&)
					break;
				}
			}
			
			if(found) {
				resultArr[resultArr.length] = row;
				resultArr[resultArr.length - 1][3] = indexOf;
			}			
		}
		
        if (resultArr.length > maximumCount) {
            oldStartIndex = i + incr;
            break;
        } else {
            oldStartIndex = 0;
        }
    }

    oldWhat = what;
    DoTheMagic(resultArr, (startIndex != 0) && (i != 0) );
}

function Clear() {
    var editBox = document.getElementById('search_box');

    if (editBox.innerHTML == 'search...') {
        editBox.innerHTML = '';
    }
}
