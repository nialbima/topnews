class FlagsController
  def toggle
    @flag = Flag.new(flag_params, user: current_user)

    if @flag.save
      redirect_to flagged_stories_path
    end
  end

  def delete
    @flag = Flag.find(params[:id])
    @flag.destroy
    # TODO: this isn't the correct target
    redirect_to flagged_stories_path
  end

  private

  def flag_params
    params.require(:flag).permit(:story_id).merge(user: current_user)
  end
end
