class PeopleController < ApplicationController
    before_action :set_person, only: [:show, :edit, :update, :destroy]

    # GET /people
    # GET /people.json
    def index
      @people = Person.all
    end

    # GET /people/1
    # GET /people/1.json
    def show
    end

    # GET /people/new
    def new
      @person = Person.new
    end

    # GET /people/1/edit
    def edit
    end

    # POST /people
    # POST /people.json
    def create
      @person = Person.new(person_params)

      attributes = person_params.clone
      if @person.ancestry.present?
        parent = Person.find(@person.ancestry)
        ancestors = parent.ancestor_ids.join("/")
        attributes[:ancestry] = ancestors + '/' + attributes[:ancestry]
        @person.update_attributes(attributes)
      end
      respond_to do |format|
        if @person.save
          format.html { redirect_to @person, notice: 'Person was successfully created.' }
          format.json { render :show, status: :created, location: @person }
        else
          format.html { render :new }
          format.json { render json: @person.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /people/1
    # PATCH/PUT /people/1.json
    def update
      attributes = person_params.clone
      logger.debug 'PATCHING: ' + @person.attributes.to_s
      logger.debug 'PARAMS RECEIVED: ' + attributes.to_s
      if attributes[:ancestry].present?
        logger.debug 'start joining ancestors'
        parent = Person.find(attributes[:ancestry])
        logger.debug 'PARENT: ' + parent.attributes.to_s
        ancestors = parent.ancestor_ids.join("/")
        attributes[:ancestry] = ancestors + '/' + attributes[:ancestry]
      end
      logger.debug attributes
      respond_to do |format|
        if @person.update(attributes)
          format.html { redirect_to @person, notice: 'Person was successfully updated.' }
          format.json { render :show, status: :ok, location: @person }
        else
          format.html { render :edit }
          format.json { render json: @person.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /people/1
    # DELETE /people/1.json
    def destroy
      @person.destroy
      respond_to do |format|
        format.html { redirect_to people_url, notice: 'Person was successfully deleted.' }
        format.json { head :no_content }
      end
    end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :parentId, :relationshipType, :ancestry)
    end
end
