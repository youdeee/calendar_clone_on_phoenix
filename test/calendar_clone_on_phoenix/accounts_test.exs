defmodule CalendarCloneOnPhoenix.AccountsTest do
  use CalendarCloneOnPhoenix.DataCase

  alias CalendarCloneOnPhoenix.Accounts

  describe "users" do
    alias CalendarCloneOnPhoenix.Accounts.User

    @valid_attrs %{email: "some email", password_hash: "some password_hash"}
    @update_attrs %{email: "some updated email", password_hash: "some updated password_hash"}
    @invalid_attrs %{email: nil, password_hash: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password_hash == "some password_hash"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.password_hash == "some updated password_hash"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "events" do
    alias CalendarCloneOnPhoenix.Accounts.Event

    @valid_attrs %{
      date: ~D[2010-04-17],
      description: "some description",
      name: "some name",
      place: "some place"
    }
    @update_attrs %{
      date: ~D[2011-05-18],
      description: "some updated description",
      name: "some updated name",
      place: "some updated place"
    }
    @invalid_attrs %{date: nil, description: nil, name: nil, place: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Accounts.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Accounts.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Accounts.create_event(@valid_attrs)
      assert event.date == ~D[2010-04-17]
      assert event.description == "some description"
      assert event.name == "some name"
      assert event.place == "some place"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Accounts.update_event(event, @update_attrs)
      assert event.date == ~D[2011-05-18]
      assert event.description == "some updated description"
      assert event.name == "some updated name"
      assert event.place == "some updated place"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_event(event, @invalid_attrs)
      assert event == Accounts.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Accounts.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Accounts.change_event(event)
    end
  end
end
