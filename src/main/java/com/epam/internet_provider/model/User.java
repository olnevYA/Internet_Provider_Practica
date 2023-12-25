package com.epam.internet_provider.model;

import lombok.Data;

import javax.persistence.Column;
import java.util.List;
/**
 * Class User that has properties: {@link User#id}, {@link User#login}, {@link User#password},
 * {@link User#email}, {@link User#bonusAmount}, {@link User#cash}, {@link User#role}, {@link
 * User#status}, {@link User#tariff} and {@link User#rewards}.
 */
@Data
public class User {
  @Column(name = "user_id")
  private int id;

  @Column(name = "login")
  private String login;

  private String password;

  @Column(name = "email")
  private String email;

  @Column(name = "bonus_amount")
  private int bonusAmount;

  @Column(name = "cash")
  private int cash;

  private Role role;
  private Status status;
  private Tariff tariff;
  private List<Reward> rewards;
}
