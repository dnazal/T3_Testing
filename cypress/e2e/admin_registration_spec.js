describe('Admin Registration', () => {
    it('registers a new admin successfully', () => {
      cy.visit('/register');
      cy.get('input[name="user[email]"]').type('admin@example.com');
      cy.get('input[name="user[name]"]').type('Admin User');
      cy.get('input[name="user[password]"]').type('securePassword123');
      cy.get('input[name="user[password_confirmation]"]').type('securePassword123');
      cy.get('input[name="user[role]"]').type('admin');  
  
      // Submit the form
      cy.get('form').submit();
      cy.url().should('include', '/');  
    });
  });



  
  
  
  