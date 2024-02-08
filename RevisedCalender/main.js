const title = document.querySelector(".date-title");
const lastMonthBtn = document.querySelector(".last-month-btn");
const nextMonthBtn = document.querySelector(".next-month-btn");
const todayBtn = document.querySelector(".today-btn");
const modalAstroInfo = document.querySelector(".modal-title2");
const createtodoModal = document.querySelector("#create_todo_modal");
const updateModal = bootstrap.Modal.getOrCreateInstance("#update_todo_modal");
const updateDateInput = document.querySelector("#date_update_input");
let jotDown = document.getElementById("jotDown");
let btnAdd = document.getElementById("btnAdd");
let modalsidebody = document.querySelector("#modalsidebody");

window.onload = () => {
  initCalendar();
};

function initCalendar() {
  currentYear = today.getFullYear();
  currentMonth = today.getMonth() + 1;
  showTitle(currentYear, currentMonth);
  fetchAstroEvent("/AstrologicalEvent2024.json");
}

let Astro2024 = {};
function fetchAstroEvent(url) {
  fetch(url)
    .then((response) => response.json())
    .then((AstroData) => {
      Astro2024 = AstroData;
      renderingCalendar();
    })
    .then(getTodoFromStorage())
    .catch((err) => {
      alert(`error:${err}`);
    });
}
//日曆畫面上半部渲染
const today = new Date();
let currentYear;
let currentMonth;

const localStorageKey = "my-todo";
let todoItemObj = {};

todayBtn.addEventListener("click", () => {
  initCalendar();
});

lastMonthBtn.addEventListener("click", () => {
  currentMonth--;
  if (currentMonth < 1) {
    currentYear--;
    currentMonth = 12;
  }
  showTitle(currentYear, currentMonth);
  renderingCalendar();
});

nextMonthBtn.addEventListener("click", () => {
  currentMonth++;
  if (currentMonth > 12) {
    currentYear++;
    currentMonth = 1;
  }
  showTitle(currentYear, currentMonth);
  renderingCalendar();
});

function showTitle(year, month) {
  let months = [
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
  title.textContent = `${year}  ${months[month - 1].toString().padStart(2, 0)}`;
}
//日期格式
function getDateStr(date) {
  return `${date.getFullYear()}-${(date.getMonth() + 1)
    .toString()
    .padStart(2, "0")}-${date.getDate().toString().padStart(2, "0")}`;
}
//日曆日期部分渲染
function renderingCalendar() {
  const firstDateOfCurrentMonth = new Date(currentYear, currentMonth - 1, 1);
  const lastDateOfCurrentMonth = new Date(currentYear, currentMonth - 1 + 1, 0);

  let start = 1 - firstDateOfCurrentMonth.getDay();
  const end =
    lastDateOfCurrentMonth.getDate() + (6 - lastDateOfCurrentMonth.getDay());
  const dateArea = document.querySelector(".date-area");
  dateArea.innerHTML = "";

  for (start; start <= end; start++) {
    //日期部分渲染
    const curr = new Date(currentYear, currentMonth - 1, start);
    const dateDom = document.createElement("div");
    dateDom.classList.add("border", "col");

    const dateEl = document.createElement("span");
    dateEl.classList.add("d-inline-block", "w-100", "text-center");
    dateEl.textContent = curr.getDate();
    if (
      curr.getFullYear() === today.getFullYear() &&
      curr.getMonth() === today.getMonth() &&
      curr.getDate() === today.getDate()
    ) {
      dateEl.classList.add("badge", "rounded");
      dateEl.setAttribute("style", "background-color: rgb(77, 8, 8);");
    }
    dateDom.append(dateEl);
    //星歷描述部分渲染
    let astroEv = document.createElement("div");
    const dateStr = getDateStr(curr);
    Object.keys(Astro2024).includes(dateStr)
      ? (astroEv.textContent = Astro2024[dateStr])
      : (astroEv.textContent = null);
    dateDom.append(astroEv);

    //日期todo部分渲染
    const currDateStr = dateStr;
    let currTodoItems = todoItemObj[currDateStr];
    if (currTodoItems) {
      const ul = document.createElement("ul");
      currTodoItems.forEach((item) => {
        const li = document.createElement("li");
        li.textContent = item.todo;
        if (item.checked === true) {
          li.classList.add("text-decoration-line-through");
        }

        ul.append(li);
      });
      dateDom.append(ul);
    }
    dateArea.append(dateDom);

    createtodoModal.addEventListener("click", () => {
      updateDateInput.value = getDateStr(today);
      ModalRendering(updateDateInput.value);
    });

    dateDom.addEventListener("click", () => {
      updateDateInput.value = getDateStr(curr);
      ModalRendering(updateDateInput.value);
    });

    updateDateInput.addEventListener("change", () => {
      ModalRendering(updateDateInput.value);
    });
  }
}
//Modal部分渲染
//Modal標題部分渲染
function ShowModalAstroInfo(dateStr, content) {
  Object.keys(Astro2024).includes(dateStr)
    ? (modalAstroInfo.textContent = dateStr + content)
    : (modalAstroInfo.textContent = null);
}
function ModalRendering(dateStr) {
  updateModal.show();
  ShowModalAstroInfo(dateStr, Astro2024[dateStr]);
  btnAdd.addEventListener("click", CreateRecords);
  currTodoItems = todoItemObj[dateStr];
  modalsidebody.innerHTML = "";
  if (currTodoItems) {
    currTodoItems.forEach((item) => {
      let tododiv = document.createElement("div");
      let exsitingtodo = createTemplate(item.todo, item.checked);
      tododiv.innerHTML = exsitingtodo;
      modalsidebody.append(tododiv);
    });
  }
}
//Modal內部新增資訊渲染
function CreateRecords() {
  let inputGroupsDiv = document.createElement("div");
  let inputGroupsSec = document.createElement("div");
  let inputCheckDiv = document.createElement("div");
  let inputSaves = document.createElement("input");
  let inputEdits = document.createElement("input");
  let inputReset = document.createElement("input");
  let inputCheck = document.createElement("input");
  let inputText = document.createElement("input");

  inputGroupsDiv.classList.add(
    "d-flex",
    "my-1",
    "px-2",
    "py-2",
    "border",
    "rounded-2",
    "border-secondary-subtle",
    "bg-warning",
    "bg-opacity-10"
  );
  inputGroupsSec.classList.add("input-group");
  inputCheckDiv.classList.add("input-group-text");

  inputCheck.classList.add("form-check-input", "mt-0", "completed");
  inputCheck.type = "checkbox";
  inputCheck.id = "inputCheck";

  inputText.classList.add("form-control");
  if (jotDown.value.trim() === "") {
    return;
  }
  inputText.value = jotDown.value.trim();
  jotDown.value = "";
  inputText.disabled = true;
  inputText.id = "inputText";

  inputSaves.classList.add(
    "btn",
    "btn-info",
    "mx-2",
    "fw-bold",
    "opacity-10",
    "visually-hidden"
  );
  inputSaves.type = "button";
  inputSaves.value = "保存";
  inputSaves.id = "inputSaves";

  inputEdits.classList.add("btn", "btn-warning", "mx-2", "fw-bold");
  inputEdits.id = "inputEdits";
  inputEdits.type = "button";
  inputEdits.value = "編輯";

  inputReset.classList.add("btn", "btn-warning", "fw-bold");
  inputReset.id = "inputReset";
  inputReset.type = "button";
  inputReset.value = "刪除";

  inputCheckDiv.append(inputCheck);
  inputGroupsSec.append(inputCheckDiv, inputText);
  inputGroupsDiv.append(inputGroupsSec, inputSaves, inputEdits, inputReset);
  modalsidebody.append(inputGroupsDiv);

  let addcontent = { todo: inputText.value, checked: inputCheck.checked };
  setTodoToStorage(updateDateInput.value, addcontent);

  inputCheck.addEventListener("change", checkchange);
  inputEdits.addEventListener("click", edittodo);
  inputSaves.addEventListener("click", savetodo);
  inputReset.addEventListener("click", deletetodo);
  renderingCalendar();
}
function checkchange() {
  const dateStr = updateDateInput.value;
  const todoItemsOfDate = todoItemObj[dateStr];
  const inputChecks = modalsidebody.querySelectorAll("#inputCheck");
  const inputTexts = modalsidebody.querySelectorAll("#inputText");
  const index = Array.from(inputChecks).indexOf(event.target);
  todoItemsOfDate[index].checked = event.target.checked;
  if (event.target.checked) {
    inputTexts[index].classList.add("text-decoration-line-through");
  } else {
    inputTexts[index].classList.remove("text-decoration-line-through");
  }
  resetStorage();
}
function edittodo() {
  const inputEditss = modalsidebody.querySelectorAll("#inputEdits");
  const inputTexts = modalsidebody.querySelectorAll("#inputText");
  const inputSavess = modalsidebody.querySelectorAll("#inputSaves");
  const index = Array.from(inputEditss).indexOf(event.target);
  inputTexts[index].disabled = false;
  inputSavess[index].classList.remove("visually-hidden");
  inputEditss[index].classList.add("visually-hidden");
}

function savetodo() {
  const dateStr = updateDateInput.value;
  const todoItemsOfDate = todoItemObj[dateStr];
  const inputEditss = modalsidebody.querySelectorAll("#inputEdits");
  const inputTexts = modalsidebody.querySelectorAll("#inputText");
  const inputSavess = modalsidebody.querySelectorAll("#inputSaves");
  const index = Array.from(inputSavess).indexOf(event.target);
  todoItemsOfDate[index].todo = inputTexts[index].value;
  inputTexts[index].disabled = true;
  inputEditss[index].classList.remove("visually-hidden");
  inputSavess[index].classList.add("visually-hidden");
  resetStorage();
  renderingCalendar();
}
function deletetodo() {
  const inputResets = modalsidebody.querySelector("#inputReset");
  const index = Array.from(inputResets).indexOf(event.target);
  const dateStr = updateDateInput.value;
  const todoItemsOfDate = todoItemObj[dateStr];
  todoItemsOfDate.splice(index, 1);
  ModalRendering(dateStr);
  renderingCalendar();
  resetStorage();
}

//與localStorage有關
function resetStorage() {
  const jsonStr = JSON.stringify(todoItemObj);
  localStorage.setItem(localStorageKey, jsonStr);
}
function setTodoToStorage(dateStr, content) {
  if (!Array.isArray(todoItemObj[dateStr])) {
    todoItemObj[dateStr] = [];
  }
  todoItemObj[dateStr].push(content);
  resetStorage();
}
function getTodoFromStorage() {
  const todoObj = JSON.parse(localStorage.getItem(localStorageKey));
  if (todoObj) {
    todoItemObj = todoObj;
  }
}

function createTemplate(content, ISchecked) {
  return `<div
class="d-flex  my-1 px-2 py-2 border rounded-2 border-secondary-subtle bg-warning bg-opacity-10"
>
<div class="input-group">
  <div class="input-group-text">
    <input
      class="form-check-input mt-0 completed"
      type="checkbox"
      value=""
      aria-label="Checkbox for following text input"
      id="inputCheck" multiple ${ISchecked === true ? "checked" : null}
      onchange="checkchange()"
    
    />
  </div>
  <input
    type="text"
    class="form-control ${
      ISchecked === true ? "text-decoration-line-through" : null
    }"
    aria-label="Text input with checkbox"
    value="${content}" id="inputText" disabled
  />
</div>
<input class="btn btn-info mx-2 fw-bold opacity-10 visually-hidden"  type="button" value="保存" id="inputSaves" onclick="savetodo()"/>
<input class="btn btn-warning mx-2 fw-bold" type="button" value="編輯" id="inputEdits" onclick="edittodo()"/>
<input class="btn btn-warning fw-bold" type="reset" value="刪除" id="inputReset" onclick="deletetodo()"/>
</div>`;
}
