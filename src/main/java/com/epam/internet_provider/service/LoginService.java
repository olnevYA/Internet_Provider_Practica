package com.epam.internet_provider.service;

import com.epam.internet_provider.model.Credentials;

public interface LoginService {

  Credentials authenticate(Credentials credentials);
}
