# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

comment 
    # <h2>Comments</h2>
    # <% @article.comments.each do |comment| %>
    
    # <p>
    #     <% if comment.user!=nil %>
    #         <% if name_user(comment.user).avatar.attached? %>
    #         <%= image_tag name_user(comment.user).avatar %>
    #         <% end %>
    #         <h3><%=name_user(comment.user).name%>:  <%= comment.body %></h3> 
    #     <% end %>
    # </p>

    # <% end %> 
    

    <!-- <% if @article.user_id!=nil %>
    <h3><%=name_user(@article.user_id).name%></h3> 
        <% end %>
        <% if user_signed_in?  %>
        <% if @article.user_id == current_user.id %>
            <li> <%= link_to 'Edit', edit_article_path(@article) %></li>
            <li> <%= link_to 'Destroy', article_path(@article), method: :delete, data: {comfirm: "Are you sure?"} %></li>
        <% end %>    
    <% end %> -->


 targetas articles
 <!-- 
<div class='container'>
   <div class="row">
      <% @articles.each do |article| %>
      <div class="col-md-6">
         <div class="card text-white bg-success flex-md-row mb-4 shadow-sm h-md-250">
            <div class="card-body d-flex flex-column align-items-start">
               <strong class="d-inline-block mb-2 text-white"> <%= name_user(1).name %></strong>
               <h6 class="mb-0">
                  <%= link_to article.title, article, class:'text-white' %>
               </h6>
               <div class="mb-1 text-white-50 small">Nov 11</div>
               <p class="card-text mb-auto"><%= article.body %> </p>
               <%= link_to 'Continue reading', article, class:'btn btn-outline-light btn-sm' %>
            </div> 
            <% if article.logo.attached? %>
            <%= image_tag article.logo, class:'card-img-right flex-auto d-none d-lg-block', style:'width: 200px; height: 250px;'%> 
            <% else %> 
            <img class="card-img-right flex-auto d-none d-lg-block" alt="Thumbnail [200x250]"
               src="//placeimg.com/250/250/nature" style="width: 200px; height: 250px;">
            <% end %> 
         </div>
      </div>
      <% end %>
   </div>
</div>


<ul>
    <% @articles.each do |article| %>
        <li>
            <% if article.logo.attached? %>
                <%= image_tag article.logo, width: 50, height: 50 %> 
            <% end %> 
            <%= link_to article.title, article %>
            <p><%= article.body %></p>
        </li>
    <% end %>
</ul>

-->

<!--  ROOT PAGE -> LANDING PAGE 
<h1>Welcome to the root page</h1>

<% if user_signed_in? %>
    <h1> Welcome <%=current_user.name %></h1>
    <%= link_to('Salir', logout_path) %>
<% end %>




BOOKS Y COMENTARIOS

<p id="notice"><%= notice %></p>

<p>
  <strong>Title:</strong>
  <%= @book.title %>
</p>

<p>
  <strong>Abstract:</strong>
  <%= @book.abstract %>
</p>

<p>
  <strong>Price:</strong>
  <%= @book.price %>
</p>

<p>
  <strong>author</strong>
  <%= @book.author %>
</p>

<p>
  <strong>Edition</strong>
  <%= @book.edition %>
</p>

<p>
  <strong>Type of book</strong>
  <%= @book.type_book %>
</p>


<div class="container">
<%= image_tag @book.cover_page %>
</div>

<br>

<%= form_with model: [ @book, @book.reviews.build ] do |form| %>
  <p>
    <%= form.label :comment %><br>
    <%= form.text_field :comment %>
  </p>
  <p>
    <%= form.label :starts %><br>
    <%= form.text_area :starts %>
  </p>
  <p>
    <%= form.submit %>
  </p>
<% end %>

<% @book.reviews.each do |review| %>

  <p>
    <strong>review:</strong>
    <%= review.comment %>
  </p>

  <p>
    <strong>starts:</strong>
    <%= review.starts %>
  </p>

<% end %>

<%= link_to 'Edit', edit_book_path(@book) %> |
<%= link_to 'Back', books_path %>


-->

# Leraning_environment
