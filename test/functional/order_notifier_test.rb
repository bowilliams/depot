require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "You bought some shit", mail.subject
    assert_equal ["bo@bo.org"], mail.to
    assert_equal ["bowilliams@gmail.com"], mail.from
    # assert_match "Hi", mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Your shit shipped", mail.subject
    assert_equal ["bo@bo.org"], mail.to
    assert_equal ["bowilliams@gmail.com"], mail.from
    assert_match "Your shit shipped.", mail.body.encoded
  end

end
