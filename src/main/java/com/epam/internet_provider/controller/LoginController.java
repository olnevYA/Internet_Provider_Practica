package com.epam.internet_provider.controller;

import com.epam.internet_provider.model.Credentials;
import com.epam.internet_provider.model.Status;
import com.epam.internet_provider.service.LoginService;
import com.epam.internet_provider.service.impl.LoginServiceImpl;
import com.epam.internet_provider.util.CookieUtil;
import com.epam.internet_provider.util.JsonUtil;
import io.vavr.control.Try;
import org.eclipse.jetty.server.Response;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Optional;

@WebServlet(
    name = "LoginServlet",
    urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

  private LoginService loginService = new LoginServiceImpl();

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
    Try.run(
            () ->
                Optional.of(JsonUtil.parseData(req.getReader()))
                    .map(
                        jsonObject ->
                            loginService.authenticate(
                                new Credentials(
                                    jsonObject.getString("login"),
                                    jsonObject.getString("password"))))
                    .filter(credentials -> credentials.getStatus() != Status.Banned)
                    .map(
                        credentials -> {
                          resp.addCookie(
                              CookieUtil.createCookie(
                                  credentials.getLogin(), credentials.getRole()));
                          resp.setHeader("user", credentials.getLogin());
                          resp.setHeader("role", credentials.getRole().name());
                          resp.setStatus(Response.SC_OK);
                          return true;
                        }))
        .orElseRun(e -> resp.setStatus(Response.SC_FORBIDDEN));
  }
}
