package com.epam.internet_provider.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;

@AllArgsConstructor
public enum Status {
  Banned(3),
  Blocked(2),
  Active(1),
  New(0);

  @Getter private final int value;

  public static Status getStatus(int value) {
    return Arrays.stream(values()).filter(status -> status.value == value).findFirst().orElse(null);
  }
}
