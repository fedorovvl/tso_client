.class final enum Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;
.super Ljava/lang/Enum;
.source "AIRWindowSurfaceView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AIRWindowSurfaceView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "MetaKeyState"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

.field public static final enum ACTIVE:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

.field public static final enum INACTIVE:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

.field public static final enum LOCKED:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

.field public static final enum PRESSED:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 203
    new-instance v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    const-string v1, "INACTIVE"

    invoke-direct {v0, v1, v2}, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;->INACTIVE:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    .line 204
    new-instance v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    const-string v1, "ACTIVE"

    invoke-direct {v0, v1, v3}, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;->ACTIVE:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    .line 205
    new-instance v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    const-string v1, "PRESSED"

    invoke-direct {v0, v1, v4}, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;->PRESSED:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    .line 206
    new-instance v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    const-string v1, "LOCKED"

    invoke-direct {v0, v1, v5}, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;->LOCKED:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    .line 201
    const/4 v0, 0x4

    new-array v0, v0, [Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    sget-object v1, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;->INACTIVE:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    aput-object v1, v0, v2

    sget-object v1, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;->ACTIVE:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    aput-object v1, v0, v3

    sget-object v1, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;->PRESSED:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    aput-object v1, v0, v4

    sget-object v1, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;->LOCKED:Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    aput-object v1, v0, v5

    sput-object v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;->$VALUES:[Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 201
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 201
    const-class v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    return-object v0
.end method

.method public static values()[Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;
    .locals 1

    .prologue
    .line 201
    sget-object v0, Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;->$VALUES:[Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    invoke-virtual {v0}, [Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/adobe/air/AIRWindowSurfaceView$MetaKeyState;

    return-object v0
.end method
