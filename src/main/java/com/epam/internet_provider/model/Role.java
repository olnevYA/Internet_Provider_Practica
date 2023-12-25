package com.epam.internet_provider.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;

@AllArgsConstructor
public enum Role {
  Admin(1),
  User(0);

  @Getter private final int value;

  public static Role getRole(int value) {
    return Arrays.stream(values()).filter(role -> role.value == value).findFirst().orElse(null);
  }
}
