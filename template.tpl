___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "GA4 Analytics Event",
  "categories": ["ANALYTICS", "CONVERSIONI"],
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "Measurement Id",
    "displayName": "Measurement ID",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "REGEX",
        "errorMessage": "Inserire un id GA4 valido",
        "args": [
          "^G-[A-Z]{10}$"
        ]
      },
      {
        "type": "NON_EMPTY"
      }
    ],
    "alwaysInSummary": true
  },
  {
    "type": "SELECT",
    "name": "Analytics Event Parameters",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "dataLayer",
        "displayValue": "Data Layer"
      },
      {
        "value": "customEventParameters",
        "displayValue": "Custom Event Parameters"
      }
    ],
    "simpleValueType": true,
    "displayName": "Analytics Event Parameters",
    "defaultValue": "dataLayer",
    "subParams": [
      {
        "type": "SELECT",
        "name": "Custom Variable",
        "displayName": "Select Custom Variable",
        "macrosInSelect": true,
        "selectItems": [],
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "enablingConditions": [
          {
            "paramName": "Analytics Event Parameters",
            "paramValue": "customEventParameters",
            "type": "EQUALS"
          }
        ]
      }
    ],
    "alwaysInSummary": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
const log = require('logToConsole');

var choose=data["Analytics Event Parameters"];
const measurementId = data["Measurement Id"];
var objToSend = {'send_to': measurementId};
var event_name ='';
var params ='';


//Dichiarazione delle API necessarie
const createQueue = require('createQueue');
const createArgumentsQueue = require('createArgumentsQueue');
const copyFromDataLayer = require('copyFromDataLayer');


//basi gtag + altre funzioni utilitarie
const gtag = createArgumentsQueue('gtag', 'dataLayer');
const dataLayerPush = createQueue('dataLayer');

//Processa il dataLayer e invia l'evento con i parametri pushati

if(choose === "dataLayer"){
  event_name = copyFromDataLayer('eventObj').event_name;
  params = copyFromDataLayer('eventObj').params;

  for(var key in params){
  objToSend[key] = params[key];
  }
  
  if(event_name && params){ 
   gtag('event', event_name, objToSend);
   dataLayerPush({'eventObj':null,});  
  }
  
  else{
    //errore
    log("Errore di formatto:" + ' ' + "L" + "'" + "oggetto" + " 'eventObject' non è correttamente formattato. Assicurati di valorizzare entrambi le proprietà, 'event_name' e 'params'.");
  }
}

//Processa l'oggetto customEventParameters e invia l'evento

if(choose === "customEventParameters"){
  var eventObj = data["Custom Variable"];
  event_name = eventObj.event_name;
  params = eventObj.params;

  for(var key in params){
  objToSend[key] = params[key];
  }
  
  if(event_name && params){  
  gtag('event', event_name, objToSend);
  dataLayerPush({'eventObj':null,});   
  }
else{
   gtag('event', event_name);
    //errore
       log("Errore di formatto:" + ' ' + "L" + "'" + "oggetto" + " 'eventObject' non è correttamente formattato. Assicurati di valorizzare entrambi le proprietà, 'event_name' e 'params'.");
  }
}

// Call data.gtmOnSuccess when the tag is finished.
data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "gtag"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedKeys",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "event"
              },
              {
                "type": 1,
                "string": "params"
              },
              {
                "type": 1,
                "string": "eventObj"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Test
  code: |-
    const mockData = {
      // Mocked field values
    };

    // Call runCode to run the template's code.
    runCode(mockData);

    // Verify that the tag finished successfully.
    assertApi('gtmOnSuccess').wasCalled();


___NOTES___

Created on 09/01/2026, 14:10:54

