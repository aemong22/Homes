      ///////////////////////// select box 설정 (지역, 매매기간) /////////////////////////
      let date = new Date();

      window.onload = function () {
        let yearEl = document.querySelector("#year");
        let yearOpt = `<option value="">매매년도선택</option>`;
        let year = date.getFullYear();
        for (let i = year; i > year - 20; i--) {
          yearOpt += `<option value="${i}">${i}년</option>`;
        }
        yearEl.innerHTML = yearOpt;

        // 브라우저가 열리면 시도정보 얻기.
        console.log('${root}'+'/rest/house/sido');
        // 시도 정보 얻기
		const url = '${root}'+'/rest/house/sido';
		fetch(url, {
			method: 'GET'
		})
		.then((response)=>response.json()) // 역직렬화 과정
		.then((data)=>{
			addOption("sido",data)});
      };

      document.querySelector("#year").addEventListener("change", function () {
        let month = date.getMonth() + 1;
        let monthEl = document.querySelector("#month");
        let monthOpt = `<option value="">매매월선택</option>`;
        let yearSel = document.querySelector("#year");
        let m = yearSel[yearSel.selectedIndex].value == date.getFullYear() ? month : 13;
        for (let i = 1; i < m; i++) {
          monthOpt += `<option value="${i < 10 ? "0" + i : i}">${i}월</option>`;
        }
        monthEl.innerHTML = monthOpt;
      });

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

      function addOption(selid, data) {
    	console.log(data);
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

      // /////////////////////// 아파트 매매 정보 /////////////////////////
      document.querySelector("#list-btn").addEventListener("click", function () {
        let url =
          "http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev";
        let dongSel = document.querySelector("#dong");
        let dongCode=  dongSel[dongSel.selectedIndex].value;
        console.log(dongCode);
        let gugunSel = document.querySelector("#gugun");
        let regCode = gugunSel[gugunSel.selectedIndex].value.substr(0, 5);
        
        console.log(gugunSel[gugunSel.selectedIndex].value);
        let yearSel = document.querySelector("#year");
        let year = yearSel[yearSel.selectedIndex].value;
        let monthSel = document.querySelector("#month");
        let month = monthSel[monthSel.selectedIndex].value;
        
        
        let dealYM = year + month;
        let queryParams =
          encodeURIComponent("serviceKey") +
          "=" +
          "b5dmwo35rfr5DoZxbpcy4B2cpYjbCGPaazfR5waAiXH0k%2FKtuntdHAgiMcKuC%2FLuE5fveeh2l8%2BPfHreyA5WSg%3D%3D"; /*
																												 * Service
																												 */
        queryParams +=
          "&" +
          encodeURIComponent("LAWD_CD") +
          "=" +
          encodeURIComponent(regCode); /* 아파트소재 구군 */
        queryParams +=
          "&" + encodeURIComponent("DEAL_YMD") + "=" + encodeURIComponent(dealYM); /* 조회년월 */
        queryParams +=
          "&" + encodeURIComponent("pageNo") + "=" + encodeURIComponent("1"); /* 페이지번호 */
        queryParams +=
          "&" + encodeURIComponent("numOfRows") + "=" + encodeURIComponent("30"); /* 페이지당건수 */

        fetch(`${url}?${queryParams}`)
          .then((response) => response.text())
          .then((data) => {
            map_marker(data);
            return makeList(parsing(data));
          });
      });
      
      
      function initTable() {
        let tbody = document.querySelector("#aptlist");
        let len = tbody.rows.length;
        for (let i = len - 1; i >= 0; i--) {
          tbody.deleteRow(i);
        }
      }
