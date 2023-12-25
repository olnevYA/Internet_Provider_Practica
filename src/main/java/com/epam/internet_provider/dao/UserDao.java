package com.epam.internet_provider.dao;

import com.epam.internet_provider.model.Credentials;
import com.epam.internet_provider.model.User;

import java.util.List;

public interface UserDao {

  boolean registerUser(User user);

  List<User> getUsers();

  User getUser(String login);

  Credentials getCredentials(String login);

  String getData(String value, String field);

  boolean updateCash(String login, int cash);

  boolean updateTariff(String login, int tariff_id);

  boolean changeStatus(String login, int status);
}
