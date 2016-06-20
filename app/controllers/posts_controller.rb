class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :new_child, :document_download, :pdf_read ]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order('created_at DESC')
    @users = User.all
    @category = Category.all
  end

  #def mis_posts
   # @posts = current_user.posts
  #end

  # GET /posts/1
  # GET /posts/1.json
  def show

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
    @post.user_id = @post_parent.user_id
    @users = User.all
  end

  def show_child
    @post_child = @post
    @post = Post.find(params[:id])
    #@post.parent_id = @post_parent.id
    #@users = User.all
    render :show
  end

  # GET /posts/1/edit
  def edit
    @users = User.all
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @users = User.all
    @category = Category.all
    # añadimos aquí el current user y no en el index para que sea el usuario
    # autenticado el que al crear el post vea todas sus creaciones. Si lo hiciéramos en
    # el index sólo veríamos los posts del user y no los de todos los usuarios
    # @posts.user = current_user

    if @post.save
      redirect_to :action =>'index'
    else
      respond_to do |format|
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

  # Dentro de paperclip vemos que en la ruta public/system/posts/documents se guardan los documentos a descargar
  # creando una subcarpeta con la id del post al que pertenece. Vemos además, que aparecen con una numeración
  # de 000. Para evitar errores vamos a creamos las variables longitud_id y las compararemos con el id de post que le pasamos
  # A continuación creamos la variable carpeta y la comparamos con el número de 0 de la misma. Así obligaremos
  # que se vayan rellenando las carpetas de los documentos que pertenecen a post(id).
  def document_download
    file_path = @post.document_file_name
    if !file_path.nil?
      longitud_id = @post.id.to_s.size
      if longitud_id == 1
        carpeta = "00#{@post.id}"
      elsif longitud_id == 2
        carpeta = "0#{@post.id}"
      else
        carpeta = @post.id
      end

      send_file "#{Rails.root}/public/system/posts/documents/000/000/#{carpeta}/original/#{file_path}", :x_sendfile => true
    else
      redirect_to posts_url
    end
  end

  def tag_cloud
    @tags = Post.tag_counts_on(:tags)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :text, :user_id, :parent_id, :name, :document, :file, :tag_list)
    end
end
