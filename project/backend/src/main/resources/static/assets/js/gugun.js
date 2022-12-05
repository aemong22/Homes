      window.onload = function () {
        // 브라우저가 열리면 시도정보 얻기.
        sendRequest("sido", "*00000000");
      };

      // 시도가 바뀌면 구군정보 얻기.
      document.querySelector("#sido").addEventListener("change", function () {
        if (this[this.selectedIndex].value) {
          let regcode = this[this.selectedIndex].value.substr(0, 2) + "*00000";
          sendRequest("gugun", regcode);
        } else {
          initOption("gugun");
          initOption("dong");
        }
      });

      // 구군이 바뀌면 동정보 얻기.
      document.querySelector("#gugun").addEventListener("change", function () {
        if (this[this.selectedIndex].value) {
          let regcode = this[this.selectedIndex].value.substr(0, 5) + "*";
          sendRequest("dong", regcode);
        } else {
          initOption("dong");
        }
      });

      function sendRequest(selid, regcode) {
        const url = "https://grpc-proxy-server-mkvo6j4wsq-du.a.run.app/v1/regcodes";
        let params = "regcode_pattern=" + regcode + "&is_ignore_zero=true";
        fetch(`${url}?${params}`, {
            headers : { 
                'Content-Type': 'application/json',
                'Accept': 'application/json'
               }

            })
          .then((response) => response.json())
          .then((data) => { addOption(selid, data); console.log("here") });
      }

      function addOption(selid, data) {
        let opt = ``;
        initOption(selid);
        switch (selid) {
          case "sido":
            opt += `<option value="">시도선택</option>`;
            data.regcodes.forEach(function (regcode) {
              opt += `
              <option value="${regcode.code}">${regcode.name}</option>
              `;
            });
            break;
          case "gugun":
            opt += `<option value="">구군선택</option>`;
            for (let i = 0; i < data.regcodes.length; i++) {
              if (i != data.regcodes.length - 1) {
                if (
                  data.regcodes[i].name.split(" ")[1] == data.regcodes[i + 1].name.split(" ")[1] &&
                  data.regcodes[i].name.split(" ").length !=
                    data.regcodes[i + 1].name.split(" ").length
                ) {
                  data.regcodes.splice(i, 1);
                  i--;
                }
              }
            }
            let name = "";
            data.regcodes.forEach(function (regcode) {
              if (regcode.name.split(" ").length == 2) name = regcode.name.split(" ")[1];
              else name = regcode.name.split(" ")[1] + " " + regcode.name.split(" ")[2];
              opt += `
              <option value="${regcode.code}">${name}</option>
              `;
            });
            break;
          case "dong":
            opt += `<option value="">동선택</option>`;
            let idx = 2;
            data.regcodes.forEach(function (regcode) {
              if (regcode.name.split(" ").length != 3) idx = 3;
              opt += `
              <option value="${regcode.code}">${regcode.name.split(" ")[idx]}</option>
              `;
            });
        }
        document.querySelector(`#${selid}`).innerHTML = opt;
      }

      function initOption(selid) {
        let options = document.querySelector(`#${selid}`);
        options.length = 0;
      }
      
      function register(){
    	  let sido= document.querySelector("#sido");
    	  const sido_txt = sido.options[sido.selectedIndex].text;
    	  
    	  let gugun= document.querySelector("#gugun");
    	  const gugun_txt = gugun.options[gugun.selectedIndex].text;
    	  
    	  let dong= document.querySelector("#dong");
    	  const dong_txt = dong.options[dong.selectedIndex].text;
    	  
    	  if(sido.selectedIndex==0 || gugun.selectedIndex==0 || dong.selectedIndex==0){
    		  alert("주소를 선택하세요!!");
    	  }
    	  else{
    		  let txt = sido_txt+" "+gugun_txt+" "+dong_txt;
    		  document.querySelector("#juso").value=txt;
    		  
    		  document.getElementById('juso_frm').submit();
    	  }
      }
