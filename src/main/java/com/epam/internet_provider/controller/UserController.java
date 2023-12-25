package com.epam.internet_provider.controller;

import com.epam.internet_provider.dao.UserDao;
import com.epam.internet_provider.dao.impl.UserDaoImpl;
import com.epam.internet_provider.util.JsonUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.vavr.control.Try;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.eclipse.jetty.server.Response;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
    name = "UserServlet",
    urlPatterns = {"/user"})
public class UserController extends HttpServlet {

  private static final Logger LOG = LogManager.getLogger(UserController.class);
  private UserDao userDao = new UserDaoImpl();

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    Try.run(
            () -> {
              response.setContentType("application/json");
              response
                  .getWriter()
                  .print(
                      new ObjectMapper()
                          .writeValueAsString(
                              userDao.getUser(String.valueOf(request.getAttribute("login")))));
            })
        .orElseRun(
            e -> {
              LOG.error("IllegalStateException was throws in process of getting user ", e);
              response.setStatus(Response.SC_BAD_REQUEST);
            });
  }

  @Override
  protected void doPut(HttpServletRequest req, HttpServletResponse resp) {
    if (userDao.updateTariff(
        String.valueOf(req.getAttribute("login")),
        JsonUtil.parseData(Try.of(req::getReader).get()).getInt("tariff_id"))) {
      resp.setStatus(Response.SC_OK);
    } else {
      resp.setStatus(Response.SC_PAYMENT_REQUIRED);
    }
  }
}
