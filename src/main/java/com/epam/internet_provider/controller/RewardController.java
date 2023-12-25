package com.epam.internet_provider.controller;

import com.epam.internet_provider.dao.RewardDao;
import com.epam.internet_provider.dao.impl.RewardDaoImpl;
import com.epam.internet_provider.util.JsonUtil;
import io.vavr.control.Try;
import org.eclipse.jetty.server.Response;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
    name = "RewardServlet",
    urlPatterns = {"/reward"})
public class RewardController extends HttpServlet {

  private RewardDao rewardDao = new RewardDaoImpl();

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
    if (rewardDao.addReward(
        JsonUtil.parseData(Try.of(req::getReader).get()).getInt("rewardId"),
        String.valueOf(req.getAttribute("login")))) {
      resp.setStatus(Response.SC_OK);
    } else {
      resp.setStatus(Response.SC_PAYMENT_REQUIRED);
    }
  }
}
