import com.codeborne.selenide.Condition;
import com.codeborne.selenide.Configuration;
import com.epam.internet_provider.dao.UserDao;
import com.epam.internet_provider.dao.impl.UserDaoImpl;
import com.epam.internet_provider.model.User;
import org.junit.Before;
import org.junit.Test;

import static com.codeborne.selenide.Selenide.$;
import static com.codeborne.selenide.Selenide.open;

public class RegistrationTest {

  @Before
  public void setupBrowser() {
    Configuration.browser = "chrome";
  }

  @Test
  public void loginEmailUniqueValidation() {
    open("http://localhost:8080/");
    $("#register-form").click();
    $("#register-submit").shouldHave(Condition.disabled);
    $("#registration-login#registration-login").setValue("Trogg");
    $("#login-error").waitUntil(Condition.visible, 3000);
    $("#registration-email").setValue("murfrik666@gmail.com");
    $("#email-error").waitUntil(Condition.visible, 3000);
    $("#registration-login#registration-login").setValue("NewUser");
    $("#login-success").waitUntil(Condition.visible, 3000);
    $("#registration-email").setValue("newEmail@mail.ru");
    $("#email-success").waitUntil(Condition.visible, 3000);
    $("#registrationPassword").setValue("Baladonna666");
    $("#registrationPassword").shouldHave(Condition.cssClass("is-valid"));
    $("#registrationPasswordConfirm").setValue("Baladonna666");
    $("#registrationPasswordConfirm").shouldHave(Condition.cssClass("is-valid"));
    $("#register-submit").shouldNotHave(Condition.disabled);
  }
}
