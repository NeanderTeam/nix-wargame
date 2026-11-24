// nix-wargame landing: copy buttons and the yard manifest.
// The page is complete without this file; it only adds interaction.

(function () {
  "use strict";

  // ---- copy the nix run command ----
  var RESET_MS = 1800;

  function fallbackCopy(text) {
    var ta = document.createElement("textarea");
    ta.value = text;
    ta.setAttribute("readonly", "");
    ta.style.position = "fixed";
    ta.style.opacity = "0";
    document.body.appendChild(ta);
    ta.select();
    var ok = false;
    try { ok = document.execCommand("copy"); } catch (e) { ok = false; }
    document.body.removeChild(ta);
    return ok;
  }

  function copyText(text) {
    if (navigator.clipboard && window.isSecureContext) {
      return navigator.clipboard.writeText(text).then(function () { return true; }, function () { return fallbackCopy(text); });
    }
    return Promise.resolve(fallbackCopy(text));
  }

  document.querySelectorAll("[data-copy]").forEach(function (btn) {
    var label = btn.textContent;
    btn.addEventListener("click", function () {
      var target = document.getElementById(btn.getAttribute("data-copy"));
      if (!target) return;
      copyText(target.textContent.trim()).then(function (ok) {
        btn.dataset.state = ok ? "done" : "fail";
        btn.textContent = ok ? "Copied" : "Select it";
        if (!ok) {
          var range = document.createRange();
          range.selectNodeContents(target);
          var sel = window.getSelection();
          sel.removeAllRanges();
          sel.addRange(range);
        }
        setTimeout(function () {
          delete btn.dataset.state;
          btn.textContent = label;
        }, RESET_MS);
      });
    });
  });

  // ---- yard: pick a container, read its manifest, isolate its tier ----
  var yard = document.getElementById("yard");
  var panel = document.getElementById("manifest");
  if (!yard || !panel) return;

  var boxes = Array.prototype.slice.call(yard.querySelectorAll(".box"));
  var out = {
    id: panel.querySelector("[data-m=id]"),
    title: panel.querySelector("[data-m=title]"),
    tier: panel.querySelector("[data-m=tier]"),
    learn: panel.querySelector("[data-m=learn]"),
    tool: panel.querySelector("[data-m=tool]")
  };

  function select(box) {
    boxes.forEach(function (b) { b.setAttribute("aria-pressed", b === box ? "true" : "false"); });
    yard.setAttribute("data-focus", box.dataset.tier);
    out.id.firstChild.nodeValue = "Level " + box.dataset.n;
    out.title.textContent = box.dataset.title;
    out.tier.textContent = "Tier " + box.dataset.tier + " " + box.dataset.tierName;
    out.learn.textContent = box.dataset.learn;
    out.tool.textContent = box.dataset.tool;
  }

  boxes.forEach(function (box) {
    box.addEventListener("click", function () { select(box); });
  });

  // arrow keys walk the yard once a container has focus
  yard.addEventListener("keydown", function (e) {
    var i = boxes.indexOf(document.activeElement);
    if (i < 0) return;
    var next = null;
    if (e.key === "ArrowRight" || e.key === "ArrowDown") next = boxes[Math.min(i + 1, boxes.length - 1)];
    if (e.key === "ArrowLeft" || e.key === "ArrowUp") next = boxes[Math.max(i - 1, 0)];
    if (next && next !== document.activeElement) {
      e.preventDefault();
      next.focus();
    }
  });

  select(boxes[0]);
  yard.removeAttribute("data-focus"); // nothing dimmed until the visitor chooses
})();
