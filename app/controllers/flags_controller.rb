class FlagsController < ApplicationController
  def toggle
    story = Story.includes(:flags, :flagging_users).find(params["story_id"])
    flag = story.flags.find_or_initialize_by(user: current_user)

    if flag.persisted?
      flag.destroy
    else
      flag.save
    end

    respond_to do |format|
      format.turbo_stream do
        Turbo::StreamsChannel.broadcast_refresh_to(params["stream_name"])

        # The UI for flagged_stories could use some work, but this is a good start.
        render turbo_stream: turbo_stream.replace(
          "story_#{story.source_id}",
          partial: "stories/table/story_row",
          locals: {
            story: story.reload,
            current_user: current_user,
            stream_name: params["stream_name"]
          }
        )
      end
    end
  end
end
