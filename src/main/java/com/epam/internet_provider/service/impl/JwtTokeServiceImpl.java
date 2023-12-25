package com.epam.internet_provider.service.impl;

import com.epam.internet_provider.config.JwtTokenConfig;
import com.epam.internet_provider.service.JwtTokenService;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.vavr.control.Try;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Map;
import java.util.stream.Collectors;

import static java.time.ZoneOffset.UTC;

public class JwtTokeServiceImpl implements JwtTokenService {

  private JwtTokenConfig jwtTokenConfig = JwtTokenConfig.getInstance();

  @Override
  public String issueToken(String login, String role) {
    return Try.of(
            () ->
                Jwts.builder()
                    .setExpiration(
                        Date.from(
                            LocalDateTime.now()
                                .plusHours(jwtTokenConfig.getExpirationHours())
                                .toInstant(UTC)))
                    .claim("login", login)
                    .claim("role", role)
                    .signWith(SignatureAlgorithm.HS256, jwtTokenConfig.getKey())
                    .compact())
        .getOrNull();
  }

  @Override
  public Map<String, String> parseToken(String token) {
    return Jwts.parser()
        .setSigningKey(jwtTokenConfig.getKey())
        .parseClaimsJws(token)
        .getBody()
        .entrySet()
        .stream()
        .collect(Collectors.toMap(Map.Entry::getKey, t -> String.valueOf(t.getValue())));
  }

  @Override
  public int getExpirationTimeInSeconds() {
    return jwtTokenConfig.getExpirationHours() * 60 * 60;
  }
}
