var serviceUrl = "http://ssdprogram.ca/apple.php"

function initializeIDList() {
    jQuery.support.cors = true;
    var method = $('#method').val();
    $.ajax({
           type: method,
           url: serviceUrl
           }).done(function (data) {
                   data.forEach(function (val) {
                                initializeListCallback(val)
                                });
                   }).error(function (jqXHR, textStatus, errorThrown) {
                            $('#idList').text(jqXHR.responseText || textStatus);
                            });
    $("#idList").replaceWith("<select id='peopleList' />");

}

function initializeListCallback(val) {
    var str = "ID: " + val.id + " Name: " + val.name + " Address: " + val.streetAddress;
    $('<option value="' + val.id + '">' + val.id + '</option>').appendTo($('#peopleList'));
}

function findByID() {
    jQuery.support.cors = true;
    var id = $('#peopleList').val();
    $.getJSON(serviceUrl + "?id=" + id,
              function (data) {
              if (data == null) {
              $('#idResult').text('Person not found.');
              }
              var str = "ID: " + data.id + ' Name: ' + data.name + ' Address: ' + data.streetAddress;
              $("#idResult").replaceWith("<div id='idResult'><br/><span>" + str + "</span></div>");
              
              //sends JavaScript message to the class to save User Defaults with code below:
              var message = {
              "userDefaults":
                    {
                    "name": data.name,
                    "streetAddress" : data.streetAddress,
                    "id" : data.id
                    }
              }
              webkit.messageHandlers.callbackHandler.postMessage(message);
              })
    .fail(
          function (jqueryHeaderRequest, textStatus, err) {
          $('#idResult').text('Find error: ' + err);
          });
}

function loadUserDefaults(id) {
    jQuery.support.cors = true;
    
    
    $.getJSON(serviceUrl + "?id=" + id,
              function (data) {
              if (data == null) {
              $('#idResult').text('Please check your internet connection.');
              }
              var str = "ID: " + data.id + ' Name: ' + data.name + ' Address: ' + data.streetAddress;
              $("#idResult").replaceWith("<div id='idResult'><br/><span>" + str + "</span></div>");
              
              //sends JavaScript message to the class to save User Defaults with code below:
              var message = {
              "userDefaults":
                {
                    "name": data.name,
                    "streetAddress" : data.streetAddress,
                    "id" : data.id
                }
              }
              $("#peopleList").val(data.id);
              webkit.messageHandlers.callbackHandler.postMessage(message);
              })
    .fail(
          function (jqueryHeaderRequest, textStatus, err) {
          $('#idResult').text('Find error: ' + err);
          });
}