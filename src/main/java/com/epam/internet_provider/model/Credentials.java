package com.epam.internet_provider.model;

import lombok.*;

import javax.persistence.Column;
/**
 * Class Credentials that has properties: {@link Credentials#login}, {@link Credentials#password},
 * {@link Credentials#status} and {@link Credentials#role}.
 */
@Data
@AllArgsConstructor
@RequiredArgsConstructor
@NoArgsConstructor
public class Credentials {

  @Column(name = "login")
  @NonNull
  private String login;

  @Column(name = "password")
  @NonNull
  private String password;

  private Status status;
  private Role role;
}
