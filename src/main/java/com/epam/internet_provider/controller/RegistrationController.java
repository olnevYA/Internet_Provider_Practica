package com.epam.internet_provider.controller;

import com.epam.internet_provider.dao.UserDao;
import com.epam.internet_provider.dao.impl.UserDaoImpl;
import com.epam.internet_provider.util.CookieUtil;
import com.epam.internet_provider.util.JsonUtil;
import com.epam.internet_provider.util.UserUtil;
import io.vavr.control.Try;
import org.eclipse.jetty.server.Response;
import org.json.JSONObject;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Optional;

@WebServlet(
    name = "RegistrationServlet",
    urlPatterns = {"/registration"})
public class RegistrationController extends HttpServlet {

  private UserDao userDao = new UserDaoImpl();

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
    final JSONObject userJson = JsonUtil.parseData(Try.of(req::getReader).get());
    Try.run(
            () ->
                Optional.of(UserUtil.createDefaultUser(userJson))
                    .ifPresent(
                        user -> {
                          if (userDao.registerUser(user)) {
                            resp.addCookie(
                                CookieUtil.createCookie(user.getLogin(), user.getRole()));
                            resp.setHeader("User", user.getLogin());
                            resp.setStatus(Response.SC_CREATED);
                          } else {
                            resp.setStatus(Response.SC_BAD_REQUEST);
                          }
                        }))
        .orElseRun(e -> resp.setStatus(Response.SC_BAD_REQUEST));
  }
}
