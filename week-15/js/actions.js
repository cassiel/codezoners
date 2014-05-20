$(document).ready(function () {
    $(".num").click(function () { calc.digit(this.textContent); });
    $(".op").click(function () { calc.op(this.textContent); });
    $(".enter").click(function () { calc.enter(); });
});
