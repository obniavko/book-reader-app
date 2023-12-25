import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    document.addEventListener("DOMContentLoaded", () => {
      const url = this.data.get("url");
      const filename = this.data.get("filename");

      const adobeDCView = new AdobeDC.View({ clientId: "90c82f2b2f474e58b304474d91d209e1", divId: "pdf" });
      adobeDCView.previewFile({
        content: { location: { url: url } },
        metaData: { fileName: filename }
      });
    });
  }
}
