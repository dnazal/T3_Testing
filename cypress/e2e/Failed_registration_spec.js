describe('Registration Form Validation', () => {
    it('displays an error message for invalid email', () => {
      cy.visit('/register');
      cy.get('input[name="user[email]"]').type('wrong_email_tecreo');
      cy.get('input[name="user[name]"]').type('Diego');
      cy.get('input[name="user[password]"]').type('yourPassword');
      cy.get('input[name="user[password_confirmation]"]').type('yourPassword');
      cy.get('form').submit();
      cy.url().should('include', '/register');  
    });
  });