.class public abstract Lcom/adobe/fre/FREContext;
.super Ljava/lang/Object;
.source "FREContext.java"


# instance fields
.field private m_objectPointer:J


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private native registerFunction(JLjava/lang/String;Lcom/adobe/fre/FREFunction;)V
.end method

.method private native registerFunctionCount(JI)V
.end method


# virtual methods
.method protected VisitFunctions(J)V
    .locals 5
    .param p1, "clientID"    # J

    .prologue
    .line 134
    invoke-virtual {p0}, Lcom/adobe/fre/FREContext;->getFunctions()Ljava/util/Map;

    move-result-object v2

    .line 135
    .local v2, "m":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Lcom/adobe/fre/FREFunction;>;"
    invoke-interface {v2}, Ljava/util/Map;->size()I

    move-result v3

    invoke-direct {p0, p1, p2, v3}, Lcom/adobe/fre/FREContext;->registerFunctionCount(JI)V

    .line 136
    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    .line 137
    .local v1, "it":Ljava/util/Iterator;, "Ljava/util/Iterator<Ljava/util/Map$Entry<Ljava/lang/String;Lcom/adobe/fre/FREFunction;>;>;"
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    .line 139
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/Map$Entry;

    .line 140
    .local v0, "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/adobe/fre/FREFunction;>;"
    invoke-interface {v0}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/adobe/fre/FREFunction;

    invoke-direct {p0, p1, p2, v3, v4}, Lcom/adobe/fre/FREContext;->registerFunction(JLjava/lang/String;Lcom/adobe/fre/FREFunction;)V

    goto :goto_0

    .line 142
    .end local v0    # "e":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Ljava/lang/String;Lcom/adobe/fre/FREFunction;>;"
    :cond_0
    return-void
.end method

.method public native dispatchStatusEventAsync(Ljava/lang/String;Ljava/lang/String;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public abstract dispose()V
.end method

.method public native getActionScriptData()Lcom/adobe/fre/FREObject;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native getActivity()Landroid/app/Activity;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public abstract getFunctions()Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/adobe/fre/FREFunction;",
            ">;"
        }
    .end annotation
.end method

.method public native getResourceId(Ljava/lang/String;)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;,
            Landroid/content/res/Resources$NotFoundException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method

.method public native setActionScriptData(Lcom/adobe/fre/FREObject;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/adobe/fre/FREWrongThreadException;,
            Ljava/lang/IllegalArgumentException;,
            Ljava/lang/IllegalStateException;
        }
    .end annotation
.end method
