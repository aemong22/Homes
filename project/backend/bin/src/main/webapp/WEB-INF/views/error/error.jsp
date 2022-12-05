<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Pages / Not Found 404 - NiceAdmin Bootstrap Template</title>
  <%@ include file="../common/header.jsp" %>

<body>

  <main>
    <div class="container">

      <section class="section error-404 min-vh-100 d-flex flex-column align-items-center justify-content-center">
        <h1>Error</h1>
        <h2>알 수 없는 에러가 발생했습니다.</h2>
        <a class="btn" href="${ root }">Back to home</a>
        <img src="${root }/assets/img/not-found.svg" class="img-fluid py-5" alt="Page Not Found">
        <div class="credits">
          Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
        </div>
      </section>

    </div>
  </main>
  <%@ include file="../common/footer.jsp" %>

</body>

</html>