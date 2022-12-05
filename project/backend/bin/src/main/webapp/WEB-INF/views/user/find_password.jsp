<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>Pages / Register - WhereIsMyHome</title>

      <%@ include file="../common/header.jsp" %>
    

  <body>
    <main>
      <div class="container">
        <section
          class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4"
        >
          <div class="container">
            <div class="row justify-content-center">
              <div
                class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center"
              >
                <div class="d-flex justify-content-center py-4">
                  <a href="index.html" class="logo d-flex align-items-center w-auto">
                    <img src="assets/img/logo.png" alt="" />
                    <span class="d-none d-lg-block">NiceAdmin</span>
                  </a>
                </div>
                <!-- End Logo -->

                <div class="card mb-3">
                  <div class="card-body">
                    <div class="pt-4 pb-2">
                      <h5 class="card-title text-center pb-0 fs-4">Find password</h5>
                      <p class="text-center small">Enter your personal details except password</p>
                    </div>

                    <form class="row g-3 needs-validation" novalidate>
                      <div class="col-12">
                        <label for="yourId" class="form-label">ID</label>
                        <input type="id" name="id" class="form-control" id="yourId" required />
                        <div class="invalid-feedback">Please enter a valid Id!</div>
                      </div>

                      <div class="col-12">
                        <label for="yourName" class="form-label">Name</label>
                        <input
                          type="text"
                          name="name"
                          class="form-control"
                          id="yourName"
                          placeholder="이름 입력"
                          required
                        />
                        <div class="invalid-feedback">Please enter your name!</div>
                      </div>

                      <div class="col-12">
                        <label for="yourPhone" class="form-label">Phone Number</label>
                        <input
                          type="text"
                          name="name"
                          class="form-control"
                          placeholder="010-xxxx-xxxx"
                          id="yourPhone"
                          required
                        />
                        <div class="invalid-feedback">Please enter your name!</div>
                      </div>

                      <!-- <div class="col-12">
                        <label for="yourUsername" class="form-label">Username</label>
                        <div class="input-group has-validation">
                          <span class="input-group-text" id="inputGroupPrepend">@</span>
                          <input
                            type="text"
                            name="username"
                            class="form-control"
                            id="yourUsername"
                            required
                          />
                          <div class="invalid-feedback">Please choose a username.</div>
                        </div>
                      </div> -->

                      <!--이용약관 동의-->
                      <!-- <div class="col-12">
                        <div class="form-check">
                          <input
                            class="form-check-input"
                            name="terms"
                            type="checkbox"
                            value=""
                            id="acceptTerms"
                            required
                          />
                          <label class="form-check-label" for="acceptTerms"
                            >I agree and accept the <a href="#">terms and conditions</a></label
                          >
                          <div class="invalid-feedback">You must agree before submitting.</div>
                        </div>
                      </div> -->

                      <div class="col-12">
                        <button class="btn btn-primary w-100" type="submit">Find password</button>
                      </div>
                      <div class="col-12">
                        <p class="small mb-0">
                          Already have an account? <a href="pages-login.html">Log in</a>
                        </p>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </main>
    <!-- End #main -->

    
  </body>
</html>
