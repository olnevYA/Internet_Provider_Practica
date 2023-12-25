package com.epam.internet_provider.filter;

import com.epam.internet_provider.service.JwtTokenService;
import com.epam.internet_provider.service.impl.JwtTokeServiceImpl;
import io.vavr.control.Try;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;

@WebFilter(urlPatterns = {"*.jsp", "/payment", "/user", "/tariff", "/reward"})
public class JwtFilter implements Filter {
  private JwtTokenService jwtTokenService = new JwtTokeServiceImpl();

  @Override
  public void init(FilterConfig filterConfig) {}

  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
    Try.run(
            () -> {
              jwtTokenService
                  .parseToken(
                      Arrays.stream(((HttpServletRequest) request).getCookies())
                          .filter(cookie -> "token".equals(cookie.getName()))
                          .map(Cookie::getValue)
                          .findFirst()
                          .orElse(null))
                  .entrySet()
                  .stream()
                  .filter(
                      claims -> "role".equals(claims.getKey()) || "login".equals(claims.getKey()))
                  .forEach(claims -> request.setAttribute(claims.getKey(), claims.getValue()));
              chain.doFilter(request, response);
            })
        .orElseRun(throwable -> Try.run(() -> ((HttpServletResponse) response).sendRedirect("/")));
  }

  @Override
  public void destroy() {}
}
