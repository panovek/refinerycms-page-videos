Refinery::Videos::Admin::VideosController.class_eval do

  def append_to_wym
    @video = ::Refinery::Videos::Video.find(params[:video_id])
    params['video'].each do |key, value|
      @video.config[key.to_sym] = value
    end
    if (params[:return_html])
      render :inline => @video.to_html
    else
      @html_for_wym = @video.to_html
      render
    end
  end
end
