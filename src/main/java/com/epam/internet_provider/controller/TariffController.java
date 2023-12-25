package com.epam.internet_provider.controller;

import com.epam.internet_provider.dao.TariffDao;
import com.epam.internet_provider.dao.impl.TariffDaoImpl;
import com.epam.internet_provider.model.HttpAttribute;
import com.epam.internet_provider.model.Role;
import com.epam.internet_provider.util.AttributesUtil;
import com.epam.internet_provider.util.JsonUtil;
import com.epam.internet_provider.util.TariffUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.vavr.control.Try;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.eclipse.jetty.server.Response;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Optional;
import java.util.function.Supplier;

@WebServlet(
    name = "TariffServlet",
    urlPatterns = {"/tariff"})
public class TariffController extends HttpServlet {

  private static final Logger LOG = LogManager.getLogger(TariffController.class);
  private TariffDao tariffDao = new TariffDaoImpl();

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    Try.run(
            () -> {
              response.setContentType("application/json");
              response
                  .getWriter()
                  .print(new ObjectMapper().writeValueAsString(tariffDao.getTariffs()));
            })
        .orElseRun(
            e -> {
              LOG.error("IllegalStateException was throws in process of getting tariffs ", e);
              response.setStatus(Response.SC_UNAUTHORIZED);
            });
  }

  @Override
  protected void doPut(HttpServletRequest req, HttpServletResponse resp) {
    doAdminAction(
        req,
        resp,
        () ->
            tariffDao.updateTariff(
                TariffUtil.createTariff(JsonUtil.parseData(Try.of(req::getReader).get()))));
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
    doAdminAction(
        req,
        resp,
        () ->
            tariffDao.createTariff(
                TariffUtil.createTariff(JsonUtil.parseData(Try.of(req::getReader).get()))));
  }

  @Override
  protected void doDelete(HttpServletRequest req, HttpServletResponse resp) {
    doAdminAction(
        req, resp, () -> tariffDao.deleteTariff(Integer.parseInt(req.getParameter("tariff_id"))));
  }

  private void doAdminAction(
      HttpServletRequest req, HttpServletResponse resp, Supplier<Boolean> action) {
    Optional.ofNullable(AttributesUtil.getAttributes(req).getAttribute(HttpAttribute.Role))
        .filter(role -> role.equals(Role.Admin.name()))
        .map(
            role -> {
              if (!action.get()) {
                resp.setStatus(Response.SC_BAD_REQUEST);
              } else {
                resp.setStatus(Response.SC_OK);
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
