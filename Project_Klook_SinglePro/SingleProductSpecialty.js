window.addEventListener("scroll", (e) => {
    if (window.scrollY > 200) {
      document.getElementById("singlePro_navbar-example2").className =
        "navbar bg-body-tertiary container-fluid px-3 px-lg-5 mb-3 fs-5 d-block position-fixed z-2";
      document
        .getElementById("singlePro_navbar-example2")
        .setAttribute("style", "top:77px");
    }
    if (window.scrollY < 200) {
      document.getElementById("singlePro_navbar-example2").className =
        "navbar bg-body-tertiary px-3 mb-3 fs-5 d-none";
    }

    let singlePro_layout_top = document.getElementById(
      "singlePro_layout_top"
    );
    let singlePro_layout_packageOption = document.getElementById(
      "singlePro_layout_packageOption"
    );
    let singlePro_layout_activityIntro = document.getElementById(
      "singlePro_layout_activityIntro"
    );
    let singlePro_layout_heed = document.getElementById(
      "singlePro_layout_heed"
    );
    let singlePro_layout_rating = document.getElementById(
      "singlePro_layout_rating"
    );

    if (window.scrollY > singlePro_layout_top.offsetTop) {
      document
        .querySelector('a[href="#singlePro_layout_top"]')
        .classList.add("active");
    }
    if (window.scrollY > singlePro_layout_packageOption.offsetTop) {
      document
        .querySelector('a[href="#singlePro_layout_top"]')
        .classList.remove("active");
      document
        .querySelector('a[href="#singlePro_layout_packageOption"]')
        .classList.add("active");
    }
    if (window.scrollY > singlePro_layout_activityIntro.offsetTop) {
      document
        .querySelector('a[href="#singlePro_layout_packageOption"]')
        .classList.remove("active");
      document
        .querySelector('a[href="#singlePro_layout_activityIntro"]')
        .classList.add("active");
    }
    if (window.scrollY > singlePro_layout_heed.offsetTop) {
      document
        .querySelector('a[href="#singlePro_layout_activityIntro"]')
        .classList.remove("active");
      document
        .querySelector('a[href="#singlePro_layout_heed"]')
        .classList.add("active");
    }
    if (window.scrollY > singlePro_layout_rating.offsetTop) {
      document
        .querySelector('a[href="#singlePro_layout_heed"]')
        .classList.remove("active");
      document
        .querySelector('a[href="#singlePro_layout_rating"]')
        .classList.add("active");
    }
  });
  document
    .querySelector('img[src="/Project_Klook_SinglePro/icons8-favorite-50.png"]').parentElement.addEventListener("mousemove", () => {
      document
        .querySelector('img[src="/Project_Klook_SinglePro/icons8-favorite-50.png"]')
        .setAttribute("src", "/Project_Klook_SinglePro/favorite_orange.png");
      document.querySelector(
        'img[src="/Project_Klook_SinglePro/favorite_orange.png"]'
      ).parentElement.style.color = "#ff5B00";
    });

  //   document
  //     .querySelector('img[src="/favorite_orange.png"]')
  //     .parentNode.addEventListener("mouseleave", () => {
  //       document
  //         .querySelector('img[src="/favorite_orange.png"]')
  //         .setAttribute("src", "/icons8-favorite-50.png");
  //       document.querySelector(
  //         'img[src="/icons8-favorite-50.png"]'
  //       ).parentNode.style.color = "black";
  //     });

  $("#singlePro_dateinput").click(function () {
    $("#inline_cal").show();
  });
  $("#inline_cal").click(function () {
    $("#inline_cal").hide();
  });

  document.querySelector("#inline_cal").addEventListener("click", () => {
    var result = document.querySelector("#result");
    var i, month;
    var monthName = result.value.split(" ")[0];
    var months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    i = months.indexOf(monthName);
    month = i + 1;
    var day = result.value.split(" ")[1];
    var year = result.value.split(" ")[2];
    document.querySelector(
      "#singlePro_dateinput"
    ).innerHTML = `<img src="/Project_Klook_SinglePro/icons8-schedule-64.png"  alt="" style="width: 20px;height: 20px; vertical-align: baseline;"> ${year}年${month}月${day}日`;
  });

  document
    .querySelector(".form-select")
    .addEventListener("mousedown", function (event) {
      event.preventDefault();
    });
// 計數器
    var app = new Vue({
    el: '#app',
        data: {
 
        }
    })      
    var app = new Vue({
    el: '#app1',
        data: {
 
        }
    })
//這裡是艾美寒舍區
var app = new Vue({
    el: '#app2',
        data: {
 
        }
    })
    var app = new Vue({
    el: '#app3',
        data: {
 
        }
    })
    var app = new Vue({
    el: '#app4',
        data: {
 
        }
    })
    var app = new Vue({
    el: '#app5',
        data: {
 
        }
    })

const CurrDate = new Date();
let weekday= CurrDate.getDay();
let operationInfoArr = [
 "週日	06:30 - 10:00,11:30 - 14:00,15:00 - 17:00,18:00 - 21:00",
 "週一	06:30 - 10:00,11:30 - 14:00,15:00 - 17:00,18:00 - 21:00",
 "週二	06:30 - 10:00,11:30 - 14:00,15:00 - 17:00,18:00 - 21:00",
 "週三	06:30 - 10:00,11:30 - 14:00,15:00 - 17:00,18:00 - 21:00",
 "週四	06:30 - 10:00,11:30 - 14:00,15:00 - 17:00,18:00 - 21:00",
 "週五	06:30 - 10:00,11:30 - 14:00,15:00 - 17:00,18:00 - 21:00",
 "週六	06:30 - 10:00,11:30 - 14:00,15:00 - 17:00,18:00 - 21:00"
] 
const tooltipContent= function(){ 
let content = "";
let contentSum=""
operationInfoArr.forEach(item => {
    content += `<div class="fs-5 text-dark">${item} + <br>`;
});
contentSum=`<div class="bg-light"> <div class="fw-bold fs-4">營業時間</div><div>${content}</div></div>`;
return contentSum;
}
document.getElementById("operationInfo").title = tooltipContent();
$(function () {
$('[data-bs-toggle="tooltip"]').tooltip();
$('[data-bs-toggle="tooltip"]').html(`${operationInfoArr[weekday]} ⌵ `);
//$('[data-bs-toggle="tooltip"]').attr('title', tooltipContent());
})
