package com.epam.internet_provider.controller;

import com.epam.internet_provider.dao.UserDao;
import com.epam.internet_provider.dao.impl.UserDaoImpl;
import com.epam.internet_provider.model.Status;
import com.epam.internet_provider.util.JsonUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.vavr.control.Try;
import org.eclipse.jetty.server.Response;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Optional;

@WebServlet(
    name = "UserStatusServlet",
    urlPatterns = {"/userStatus"})
public class UserStatusController extends HttpServlet {
  private UserDao userDao = new UserDaoImpl();

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    Try.run(
            () -> {
              response.setContentType("application/json");
              response.getWriter().print(new ObjectMapper().writeValueAsString(Status.values()));
            })
        .orElseRun(throwable -> response.setStatus(Response.SC_UNAUTHORIZED));
  }

  @Override
  protected void doPut(HttpServletRequest req, HttpServletResponse resp) {
    Optional.of(JsonUtil.parseData(Try.of(req::getReader).getOrNull()))
        .map(
            json -> {
              if (!userDao.changeStatus(
                  json.getString("login"), Status.valueOf(json.getString("status")).getValue())) {
                resp.setStatus(Response.SC_FORBIDDEN);
              }
              return true;
            })
        .orElseGet(
            () -> {
              resp.setStatus(Response.SC_FORBIDDEN);
              return false;
            });
  }
}
