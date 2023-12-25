package com.epam.internet_provider.service.impl;

import com.epam.internet_provider.dao.UserDao;
import com.epam.internet_provider.dao.impl.UserDaoImpl;
import com.epam.internet_provider.model.Credentials;
import com.epam.internet_provider.model.Status;
import com.epam.internet_provider.service.DecryptionService;
import com.epam.internet_provider.service.LoginService;
import com.epam.internet_provider.util.HashingUtil;

import java.util.Optional;

public class LoginServiceImpl implements LoginService {

  private UserDao userDao = new UserDaoImpl();
  private DecryptionService decryptionService = new DecryptionServiceImpl();

  @Override
  public Credentials authenticate(Credentials authData) {
    return Optional.of(userDao.getCredentials(authData.getLogin()))
        .filter(
            credentials ->
                HashingUtil.checkString(
                        decryptionService.decryptString(authData.getPassword()),
                        credentials.getPassword())
                    && credentials.getStatus() != Status.Banned)
        .orElse(null);
  }
}
