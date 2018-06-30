extends KinematicBody

#state machine
var PlayerChaseState = load("res://player/states/PlayerChaseState.gd")
var StateMachine = load("res://fsm/StateMachine.gd")

var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")

var speed = 400
var direction = Vector3()
var gravity = -9.8
var velocity = Vector3()
var mStateMachine = 0
var mPlayerChaseState = 0

var mSteeringBehaviors = 0

var mBall = 0



func _init():
	#steering
	mSteeringBehaviors = SteeringBehaviors.new(self)
	
	#state machine
	mStateMachine = StateMachine.new(self)
	mPlayerChaseState = PlayerChaseState.new()
	mStateMachine.changeState(mPlayerChaseState)

func _ready():
	pass

func _physics_process(delta):
	direction = Vector3(0,0,0)
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1

	direction = direction.normalized()
	direction = direction * speed * delta

	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z

	velocity = move_and_slide(velocity, Vector3(0,1,0))

	mStateMachine.update()
	mSteeringBehaviors.calculate()
	
func setBall(ball):
	mBall = ball
	
func getBall():
	return mBall

func isBallWithingKickingRange():
	#var p3D = Position3D;
	#var ballP3D = $Ball.Position3D
	#var ball = get_node("/root/ball/Ball")
	#var ballP3D = ball.Position3D
	
	#var distanceFromBall = distance_squared_to(Position3D,mBall.Position3D)
	#print("distanceFromBall:",distanceFromBall)
	pass
	
	
