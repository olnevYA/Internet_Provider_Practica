package com.epam.internet_provider.controller;

import com.epam.internet_provider.service.DecryptionService;
import com.epam.internet_provider.service.impl.DecryptionServiceImpl;
import io.vavr.control.Try;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
    name = "EncryptServlet",
    urlPatterns = {"/encrypt"})
public class EncryptController extends HttpServlet {

  private DecryptionService decryptionService = new DecryptionServiceImpl();

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    response.setContentType("text/plain");
    Try.run(() -> response.getWriter().print(decryptionService.getPublicKey()));
  }
}
