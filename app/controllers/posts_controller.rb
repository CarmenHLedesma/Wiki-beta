class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :new_child]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @users = User.all
  end

  #def mis_posts
   # @posts = current_user.posts
  #end

  # GET /posts/1
  # GET /posts/1.json
  def show
    post = @post
  end

  # añadimos user a nuestro controller (no es necesario crear un controlador nuevo con user)
  # para poder añadir los select users en la vista
  # GET /posts/new
  def new
    @post = Post.new
    @users = User.all
  end

  def new_child
    @post_parent = @post
    @post = Post.new
    @post.parent_id = @post_parent.id
    @users = User.all
  end

  # GET /posts/1/edit
  def edit
    @users = User.all
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    # añadimos aquí el current user y no en el index para que sea el usuario
    # autenticado el que al crear el post vea todas sus creaciones. Si lo hiciéramos en
    # el index sólo veríamos los posts del user y no los de todos los usuarios
    # @posts.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :text, :user_id, :parent_id)
    end
end
