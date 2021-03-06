        var processingString = "";

       $(document).ready(function(){ 
        
        var url;
        var languages = ["EN","FR","PL","DE","ZU","AF","AR","TH","RU","KO","PT","EN"];
        var currentLang;
        var nextLang;
        var currentLangEng;
        var nextLangEng;
        var translateInput;
        var result = [];
        var resultEng = [];
        var translationCount = 0;
        var translationCountEng = 0;
        var userInput;
        
        /* translate */
        function translate() { 
            if (translationCount < 11) {
                if (translationCount === 0){
                    var combinedInput = $("#formInput").val() + $("#formInput2").val() + $("#formInput3").val();
                    translateInput = encodeURI(combinedInput);
                }
    
                else {
                    console.log("input: " + result[translationCount-1]);
                    translateInput = encodeURI(result[translationCount-1]);
                }
                
                currentLang = languages[translationCount];
                nextLang = languages[(translationCount + 1)];
                
                console.log ("tCount: " + translationCount);

                console.log ("current language: " + currentLang);
                console.log ("next language: " + nextLang);
                url = "https://translation.googleapis.com/language/translate/v2?key=AIzaSyDR3NPgTSVCs633RyvRG94_awHZuuqGC4A";
                url += "&source=" + currentLang; 
                url += "&target=" + nextLang;
                url += "&q=" + translateInput;
                
                console.log(url);
                  
                $.get(url, function (data, status) {
                processingString += "/" + data.data.translations[0].translatedText;
                $("#result").append(data.data.translations[0].translatedText + "<br>");
                if(status == "success") {
                    var done = data.data.translations[0].translatedText;
                    result.push(done);
                    console.log("done: " + done);
                    console.log("result " + translationCount +": " + result[translationCount]);
                    url = "";
                    translationCount++;
                    translate();
                    if (translationCount == 11) {
                        translateEng();
                    }
                }
                });
            }
        }
        
        function translateEng() {
            if (translationCountEng < 10) {
                console.log("eng count " + translationCountEng);
                translateInput = encodeURI(result[translationCountEng]);
                currentLangEng = languages[translationCountEng+1];
                nextLangEng = "EN";
                
                console.log ("tCount: " + translationCountEng);

                console.log ("current language: " + currentLangEng);
                console.log ("next language: " + nextLangEng);
                url = "https://translation.googleapis.com/language/translate/v2?key=AIzaSyDR3NPgTSVCs633RyvRG94_awHZuuqGC4A";
                url += "&source=" + currentLangEng; 
                url += "&target=" + nextLangEng;
                url += "&q=" + translateInput;
                
                console.log(url);
                  
                $.get(url, function (data, status) {
                $("#resultEng").append(decodeURI(translateInput) + "<br>");

                $("#resultEng").append("to English: " + data.data.translations[0].translatedText + "<br>");
                if(status == "success") {
                    var done = data.data.translations[0].translatedText;
                    resultEng.push(done);
                    console.log("done: " + done);
                    console.log("result " + translationCount +": " + resultEng[translationCountEng]);
                    url = "";
                    translationCountEng++;
                    translateEng();
                    if (translationCountEng === 10){
                        writeNewPost();
                        console.log("processing: " + processingString);
                        var $newCanv = $("<canvas/>").attr("id", "mycanvas");  // adds the id 

                        $("#processing").append($newCanv);
                        Processing.loadSketchFromSources('mycanvas', ['particles/particles.pde']); 
                    }
                }
                });
            }
        }
        
        
        /* initializing firebase */
        
        var config = {
            apiKey: "AIzaSyBCwLAV6RqYEPX766evjDD4SxrVyRlOY_0",
            authDomain: "lost-in-translation-68ffc.firebaseapp.com",
            databaseURL: "https://lost-in-translation-68ffc.firebaseio.com",
            projectId: "lost-in-translation-68ffc",
            storageBucket: "lost-in-translation-68ffc.appspot.com",
            messagingSenderId: "269344435801"
        };
        firebase.initializeApp(config);
        
        
        function writeNewPost() {
            // A post entry.
            console.log(userInput);

            var postData = {
                A_originalInput: userInput,
                B_Dutch: result[0],
                C_DutchToEn: resultEng[0],
                D_Spanish: result[1],
                E_SpanishToEn: resultEng[1],
                F_Zulu: result[2],
                G_ZuluToEn: resultEng[2],
                H_Korean: result[3],
                I_KoreanToEn: resultEng[3],
                J_Hawaiian: result[4],
                K_HawaiianToEn: resultEng[4],
                L_Portugues: result[5],
                M_PortugueseToEn: resultEng[5],
                N_Thai: result[6],
                O_ThaiToEn: resultEng[6],
                P_Slovak: result[7],
                Q_SlovakToEn: resultEng[7],
                R_Greek: result[8],
                S_GreekToEn: resultEng[8],
                S_something: result[9],
                T_finalOutput: result[10]   
            };
        
            // Get a key for a new Post.
            var newPostKey = firebase.database().ref().child('translations').push().key;
          
            // Write the new post's data simultaneously in the posts list and the user's post list.
            var updates = {};
            updates['/translations/' + newPostKey] = postData;
          
            return firebase.database().ref().update(updates);
        }
        
        var ref = firebase.database().ref('/translations/');

        var keys = [];
        var names = [];
        var bodys = [];
        var final = "";
        
        function displayArrayObjects(arrayObjects) {
            var len = arrayObjects.length, text = "";
    
            for (var i = 0; i < len; i++) {
                var myObject = arrayObjects[i];
                console.log(myObject);
                for (var x in myObject) {
                    text += ("<br/>" + myObject[x] + "<br/>");
                }
                text += "<br/>";
            }
    
            document.getElementById("archive").innerHTML = text;
        }
            
        ref.once('value',function(snap) {
            snap.forEach(function(item) {
                var itemVal = item.val();
                keys.push(itemVal);
                var str = JSON.stringify(itemVal);
                final += str;
                //console.log(final);
            });
            for (i=0; i < keys.length; i++) {
                names.push(keys[i].body);
                bodys.push(keys[i].name);
            }
             displayArrayObjects(keys);	
        });
        
    });