class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :new_child, :document_download, :pdf_read ]
  before_action :tag_user, only: [:new, :new_child, :edit, ]

  # GET /posts
  # GET /posts.json
  def index
    @tags = Tag.all
    # @users = User.all
    if params[:title] or params[:text] or params[:document_file_name] or params[:tag_list]
      @posts = Post.search(params[:title], params[:text],  params[:document_file_name], params[:tag_list])
    else
      @posts = Post.all.order('created_at DESC')
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  def new_child
    @post_parent = @post
    @post = Post.new
    @post.parent_id = @post_parent.id
    @post.user_id = @post_parent.user_id
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

  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @users = User.all

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
  def tag_user
    @users = User.all
    @tags = Tag.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :text, :user_id, :parent_id, :name, :file, :document, :tag_list => [] )
  end
end
