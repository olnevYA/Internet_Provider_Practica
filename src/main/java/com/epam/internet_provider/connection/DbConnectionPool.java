package com.epam.internet_provider.connection;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import io.vavr.control.Try;

import java.sql.Connection;
import java.util.Objects;

public class DbConnectionPool {

  private static final String DB_RESOURCE = "db.properties";
  private HikariDataSource dataSource;

  private DbConnectionPool() {
    dataSource =
        new HikariDataSource(
            new HikariConfig(
                Objects.requireNonNull(getClass().getClassLoader().getResource(DB_RESOURCE))
                    .getFile()));
  }

  private static class LazyHolder {
    static final DbConnectionPool INSTANCE = new DbConnectionPool();
  }

  public static DbConnectionPool getInstance() {
    return LazyHolder.INSTANCE;
  }

  public Connection getConnection() {
    return Try.of(() -> dataSource.getConnection()).getOrNull();
  }
}
