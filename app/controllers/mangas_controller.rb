class MangasController < ApplicationController
  def index
    @manga_sites = MangaSite.order(:name)
  end


  def show
    @manga = Manga.find(params[:id])
    @chapters = @manga.get_chapters
  end


  def new
    @manga_sites = MangaSite.order(:name)
    @manga = Manga.new(params[:manga])
  end


  def create
    if Manga.create(manga_params)
      redirect_to mangas_path
    else
      redirect_to new_manga_path
    end
  end


  def edit
  end


  def update
  end


  def destroy
    manga = Manga.find(params[:id])
    manga.destroy
    redirect_to mangas_path
  end


  def download
    manga = Manga.find(params[:manga_id])
    filename = params[:chapter_text].gsub(':', ' ').split(' ').join('-').downcase


    respond_to do |format|
      format.pdf do
        pdf = manga.scrape(params[:chapter_href])
        send_data pdf.render,
          filename: "#{ filename }.pdf",
          type: 'application/pdf'
      end
    end
  end


  private
  def manga_params
    params.require(:manga).permit(:manga_site_id, :title, :url)
  end
end
