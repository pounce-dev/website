current_page = window.location.pathname.split("/").pop();

function redirectToURL(link) {
    console.log("Redirecting to:", link);
    window.location.href = link;
}

function goBack() {
    window.history.back();
}