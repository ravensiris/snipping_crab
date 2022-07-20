import "../css/app.css"
import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

liveSocket.connect()

window.liveSocket = liveSocket

// Import Croppr.js
import Croppr from "croppr";
import "../node_modules/croppr/src/css/croppr.css";

// Load up all the needed elems
let formElem = document.getElementById("image");
let imagePreviewElem = document.getElementById("imagePreview");
let imageFileElem = document.getElementById("image_file");
let imageXElem = document.getElementById("image_x");
let imageYElem = document.getElementById("image_y");
let imageWidthElem = document.getElementById("image_width");
let imageHeightElem = document.getElementById("image_height");

imageFileElem.addEventListener("change", () => {
    // Assume single file selected only
    const [file] = imageFileElem.files;

    // Required for croppr to work
    imagePreviewElem.src = URL.createObjectURL(file);

    let croppr = new Croppr(imagePreviewElem);

    // Collect crop params before submit
    formElem.addEventListener("submit", () => {
        const {x, y, width, height} = croppr.getValue();
        imageXElem.value = x;
        imageYElem.value = y;
        imageWidthElem.value = width;
        imageHeightElem.value = height;
    });
})
