/**
 * Renders Recaptcha Form Elements
 */
function showRecaptcha(public_key, element){
    Recaptcha.create(public_key, element, 
    {
      theme: "blackglass",
      callback: Recaptcha.focus_response_field
    })
}