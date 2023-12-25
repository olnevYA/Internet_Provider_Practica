package com.epam.internet_provider.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
public enum HttpAttribute {
  Role("role"),
  Login("login");

  @Getter private final String name;
}
