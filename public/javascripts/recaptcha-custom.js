  Recaptcha.create("your_public_key",
    "element_id",
    {
      theme: "red",
      callback: Recaptcha.focus_response_field
    }
  );